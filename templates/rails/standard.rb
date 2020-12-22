require "colorize"
run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# GEMFILE
########################################
puts "Adding gems to default Gemfile...".colorize(:light_green)
gsub_file('Gemfile', /# gem 'redis'/, "gem 'redis'")
gsub_file('Gemfile', /^.*'byebug'.*$/, "")

inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY

    # Authentication
    gem 'devise'
    gem 'devise-i18n'

    # Authorization
    gem 'pundit'

    # Frontend
    gem 'view_component', require: 'view_component/engine'
    gem 'cloudinary'

  RUBY
end

inject_into_file 'Gemfile', after: "group :development, :test do\n" do
  <<-RUBY
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'
  # Pry for 'rails console'
  gem 'pry-rails'

  # Linting
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'standard'

  gem 'dotenv-rails'
  RUBY
end

inject_into_file 'Gemfile', after: "group :development do\n" do
  <<-RUBY
  gem 'annotate'
  gem 'bullet'
  RUBY
end

# Assets from Sprockets to Webpacker
########################################
puts "Removing Assets and Vendor folders...".colorize(:light_green)
run 'rm -rf app/assets'
run 'rm -rf vendor'

# Layout
########################################
puts "Changing layout to use webpacker instead of sprockets...".colorize(:light_green)
before = "<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>"
after  = "<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>"
gsub_file('app/views/layouts/application.html.erb', before, after)

before = "<%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>"
after  = "<%= stylesheet_pack_tag 'stylesheets', media: 'all' %>"
gsub_file('app/views/layouts/application.html.erb', before, after)


########################################
# AFTER BUNDLE
########################################
after_bundle do
  puts "\nRails generation:".colorize(:light_green)

  # Generators: Page controller
  ########################################
  puts "  - Homepage...".colorize(:light_blue)
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-stylesheets', '--no-test-framework')
  route "root to: 'pages#home'"

  # Devise install + user
  ########################################
  puts "  - Devise Authentication...".colorize(:light_blue)
  generate('devise:install')
  puts "    • User model..."
  generate('devise', 'User')
  puts "    • Devise Views..."
  generate('devise:views')

  # Pundit install
  ########################################
  puts "  - Pundit Authorization...".colorize(:light_blue)
  generate('pundit:install')

  puts "  - Model Annotation...".colorize(:light_blue)
  generate('annotate:install')

  # ActiveStorage install + cloudinary
  ########################################
  puts "  - ActiveStorage database...".colorize(:light_blue)
  rails_command('active_storage:install')

  append_file 'config/storage.yml', <<~YAML
    cloudinary:
      service: Cloudinary
  YAML

  # Apply Migrations
  ########################################
  puts "\nDatabase migration...".colorize(:light_green)
  rails_command 'db:drop db:create db:migrate'

  # App controller
  ########################################
  puts "Changing ApplicationController to use Devise and Pundit...".colorize(:light_green)
  inject_into_file 'app/controllers/application_controller.rb', before: 'end' do
    <<-RUBY
  include Pundit
  before_action :authenticate_user!

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
    RUBY
  end

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<~RUBY
    class PagesController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :home ]

      def home
      end
    end
  RUBY

  # Git ignore
  ########################################
  append_file '.gitignore', <<~TXT

    # Ignore .env file containing credentials.
    .env*
  TXT

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

  before = 'config.active_storage.service = :local'
  after = 'config.active_storage.service = :cloudinary'
  gsub_file("config/environments/development.rb", before, after)
  gsub_file("config/environments/production.rb", before, after)

  # Webpacker / Yarn
  ########################################
  append_file 'app/javascript/packs/application.js', <<~JS

    const images = require.context('../images', true)
    const imagePath = (name) => images(name, true)

    // External imports

    // Internal imports

    document.addEventListener('turbolinks:load', () => {

    });
  JS

  inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
    <<~JS
      const webpack = require('webpack');

      // Preventing Babel from transpiling NodeModules packages
      environment.loaders.delete('nodeModules');

    JS
  end

  run 'mv app/javascript app/frontend'
  run 'mkdir app/frontend/{images,stylesheets,fonts}'
  gsub_file('config/Webpacker.yml', 'source_path: app/javascript', 'source_path: app/frontend')
  gsub_file('config/Webpacker.yml', 'extract_css: false', 'extract_css: true')

  run 'yarn autoclean --init'

  # Tailwind CSS
  ########################################
  run 'yarn add tailwindcss@compat'
  run 'npx tailwindcss init'

  gsub_file('tailwind.config.js', "  purge: [],", <<-JS.chomp +
  purge: {
    content: ["./app/**/*.html.erb"],
  }
  JS
  ',')

  inject_into_file 'postcss.config.js', after: 'plugins: [' do
<<-JS.chomp +

    require("tailwindcss")
JS
','
  end

  file 'app/frontend/packs/stylesheets.css', <<~CSS
    /* Tailwind CSS */
    @import "tailwindcss/base";
    @import "tailwindcss/components";
    @import "tailwindcss/utilities";

    /* Custom CSS */
    @import "../stylesheets/application"
  CSS

  run 'touch app/frontend/stylesheets/application.css'

  # Dotenv
  ########################################
  run 'touch .env'

  # Git
  ########################################
  git add: '.'
  git commit: "-m 'Initial commit with standard template'"
end
