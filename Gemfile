source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.0.2"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.3.18", "< 0.5"
# Use Puma as the app server
gem "puma", "~> 3.0"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors', :require => 'rack/cors'
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
gem "active_model_serializers"
gem "mysql2", ">= 0.3.18", "< 0.5"
# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
gem "versionist"
gem  "nio4r", '2.0.0'
gem "config"
gem 'factory_girl_rails'
gem "devise"
gem 'byebug'

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3', '1.3.12'
  gem "byebug", platform: :mri
  gem 'ffaker', :git => 'https://github.com/EmmanuelOga/ffaker.git'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  #gem 'pg', '0.18.4'
  gem "mysql2", ">= 0.3.18", "< 0.5"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]