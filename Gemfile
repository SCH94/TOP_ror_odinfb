source 'https://rubygems.org'

ruby '2.4.1'

gem 'rails', '~> 5.1.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'figaro', '~> 1.1'
gem 'devise', '~> 4.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver', '~> 3.5'
  gem 'pg', '~> 0.21'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'faker', '~> 1.8'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'guard-rspec', '~> 4.7'
  gem 'launchy', '~> 2.4'
end

group :production do
  gem 'pg', '~> 0.21'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
