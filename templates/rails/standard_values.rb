module Values

  def render(path)
    IO.read(path)
  end

# GEMS
############################

PROD_GEMS = <<-RUBY

# Authentication
gem 'devise'
gem 'devise-i18n'

# Authorization
gem 'pundit'

# Frontend
gem 'turbo-rails'
gem 'view_component', require: 'view_component/engine'
gem 'cloudinary'

# Icons
gem 'octicons_helper'

RUBY

DEV_TEST_GEMS = <<-RUBY
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

DEV_GEMS = <<-RUBY
  gem 'annotate'
  gem 'bullet'
RUBY

# JS
############################

TAILWIND_PLUGIN = <<-JS.chomp
  plugins: [
    require('@tailwindcss/typography'),
  ]
JS

# HTML
############################
LAYOUT = <<-HTML.chomp
  <body>
    <header>
    </header>

    <main>
      <%= yield %>
      <%= render 'shared/flash_notifications' %>
    </main>

    <footer>
    </footer>
  </body>
HTML

# STORAGE
############################

CLOUDINARY = <<-YAML

cloudinary:
  service: Cloudinary
YAML

# STORAGE
############################

GIT_IGNORE = <<-TXT

# Ignore .env file containing credentials.
.env*
TXT

end
