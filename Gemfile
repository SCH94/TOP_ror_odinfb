source 'https://rubygems.org'

ruby '~> 2.4.0'

gem 'rails', '~> 5.1.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2'
gem 'autoprefixer-rails', '~> 7.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'figaro', '~> 1.1'
gem 'devise', '~> 4.3'
gem 'bootstrap-sass', '~> 3.3'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2', '~> 0.5.2'
gem 'font-awesome-rails', '~> 4.7'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver', '~> 3.5'
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'chromedriver-helper', '~> 1.1'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'faker', '~> 1.8'
end

group :development, :production do
  gem 'pg', '~> 0.21'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
end

group :test do
  gem 'guard-rspec', '~> 4.7'
  gem 'launchy', '~> 2.4'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'capybara-email', '~> 2.5'
  gem 'email_spec', '~> 2.1'
  gem 'shoulda-matchers', '~> 3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
