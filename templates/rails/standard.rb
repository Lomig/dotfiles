require "colorize"
require "~/.dotfiles/templates/rails/standard_values"

run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

def replace_file_with_values(path)
  remove_file(path)
  file(path, IO.read(File.expand_path("~/.dotfiles/templates/rails/standard/#{path}")))
end

########################################
# BEFORE BUNDLE
########################################

# GEMFILE
########################################
puts "Adding gems to default Gemfile...".colorize(:light_green)

gsub_file('Gemfile', /# gem 'redis'/, "gem 'redis'")
gsub_file('Gemfile', /^.*'byebug'.*\n/, "")

inject_into_file('Gemfile', Values::PROD_GEMS,     before: 'group :development, :test do')
inject_into_file('Gemfile', Values::DEV_TEST_GEMS, after: "group :development, :test do\n")
inject_into_file('Gemfile', Values::DEV_GEMS,      after: "group :development do\n")

# Layout
########################################
puts "Changing application layout...".colorize(:light_green)

before = /<%= javascript.*/
after  = "<%= javascript_pack_tag 'application', defer: true %>"
gsub_file('app/views/layouts/application.html.erb', before, after)

before = /<%= stylesheet.*/
after  = "<%= stylesheet_pack_tag 'stylesheets', media: 'all' %>"
gsub_file('app/views/layouts/application.html.erb', before, after)

before = /^\s*<body>.*<\/body>/m
after = Values::LAYOUT
gsub_file('app/views/layouts/application.html.erb', before, after)

########################################
# AFTER BUNDLE
########################################
after_bundle do

  # Add JS modules
  #   - Turbo-rails
  #   - Tailwind CSS
  #   - Github Octicons
  ########################################
  puts "Adding JS modules...".colorize(:light_green)
  run 'yarn add @hotwired/turbo-rails @primer/octicons tailwindcss@compat @tailwindcss/typography postcss-import-ext-glob @fullhuman/postcss-purgecss'
  run 'yarn remove @rails/ujs'

  # Tailwind CSS specifics
  ########################################
  run 'npx tailwindcss init --full'
  gsub_file('tailwind.config.js', "  purge: [],\n", "")

  before = "  plugins: []"
  after  = Values::TAILWIND_PLUGIN
  gsub_file('tailwind.config.js', before, after)

  # Generators: Page controller + route
  ########################################
  puts "Generating Home Page...".colorize(:light_green)
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-stylesheets', '--no-test-framework')
  route "root to: 'pages#home'"

  # Devise install + user
  ########################################
  puts "\nGem installation:".colorize(:light_green)
  # puts "  - Devise Authentication...".colorize(:light_blue)
  # generate('devise:install')
  # puts "    • User model..."
  # generate('devise', 'User')
  # puts "    • Devise Views..."
  # generate('devise:views')

  # Pundit install
  ########################################
  # puts "  - Pundit Authorization...".colorize(:light_blue)
  # generate('pundit:install')

  # puts "  - Model Annotation...".colorize(:light_blue)
  # generate('annotate:install')

  # ActiveStorage install + cloudinary
  ########################################
  puts "  - ActiveStorage database...".colorize(:light_blue)
  rails_command('active_storage:install')
  append_file('config/storage.yml', Values::CLOUDINARY)

  before = 'config.active_storage.service = :local'
  after  = 'config.active_storage.service = :cloudinary'
  gsub_file("config/environments/development.rb", before, after)
  gsub_file("config/environments/production.rb", before, after)

  # Viewcomponent Helpers
  ########################################
  puts "  - ViewComponents...".colorize(:light_blue)
  run('cp -R ~/.dotfiles/templates/rails/standard/lib/rails lib/')
  replace_file_with_values('app/helpers/view_component_helper.rb')

  # Migrations
  ########################################
  puts "Database migration...".colorize(:light_green)
  rails_command 'db:drop db:create db:migrate'

  # Application Controllers
  ########################################
  puts "Changing Controllers to use Devise and Pundit...".colorize(:light_green)
  replace_file_with_values('app/controllers/application_controller.rb')
  replace_file_with_values('app/controllers/pages_controller.rb')

  # Environments
  ########################################
  environment(
    'config.action_mailer.default_url_options = { host: "http://localhost:3000" }',
    { env: 'development' })
  environment(
    'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }',
    { env: 'production' })

  # Webpacker replacing Sprockets
  ########################################

  File.rename("app/javascript", "app/frontend")

  ["images", "stylesheets", "fonts"].each { |dir| empty_directory("app/frontend/#{dir}") }

  replace_file_with_values("app/frontend/packs/application.js")
  replace_file_with_values("app/frontend/packs/stylesheets.css")
  replace_file_with_values('app/frontend/stylesheets/application.css')
  replace_file_with_values('app/frontend/controllers/index.js')
  replace_file_with_values('config/webpack/environment.js')


  gsub_file('config/Webpacker.yml', 'source_path: app/javascript', 'source_path: app/frontend')
  gsub_file('config/Webpacker.yml', 'additional_paths: []', "additional_paths: ['app/components']")
  gsub_file('config/Webpacker.yml', 'extract_css: false', 'extract_css: true')

  remove_file('postcss.config.js')
  run "cp ~/.dotfiles/templates/rails/standard/postcss.config.js ./"

  # Components
  ########################################
  run "cp -R ~/.dotfiles/templates/rails/standard/app/components app/"
  run "cp -R ~/.dotfiles/templates/rails/standard/app/views/shared app/views"


  # Dotenv
  ########################################
  create_file('.env')

  # Assets from Sprockets to Webpacker
  ########################################
  puts "Removing Assets and Vendor folders...".colorize(:light_green)
  remove_dir('app/assets')
  remove_dir('vendor')

  # Git
  ########################################
  append_file('.gitignore', Values::GIT_IGNORE)
  git add: '.'
  git commit: "-m 'Initial commit with standard template'"
end
