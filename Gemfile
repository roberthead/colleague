source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "sassc-rails"
gem "haml-rails"
gem "devise"
gem "pundit"
gem "view_component"
# gem "ruby-openai"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "rspec-rails", "~> 6.0.0"

  gem "standard", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "factory_bot_rails", require: false
  gem "rails-controller-testing"
  gem "rspec-its"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "selenium-webdriver"
  gem "webdrivers"
end
