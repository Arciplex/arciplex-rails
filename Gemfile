source 'https://rubygems.org'
ruby "2.1.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'unicorn'
gem 'devise'
gem 'turbolinks'
gem 'aasm'
gem "gritter", "1.1.0"
gem "cancan"
gem "will_paginate", '~> 3.0'
gem 'will_paginate-bootstrap'

gem "rails_12factor", group: :production
gem 'mandrill_mailer'

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'bootstrap-sass', '~> 3.0.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jquery-rails'
  gem "font-awesome-rails"
end

group :development, :test do
  gem 'debugger'
  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'guard-spork'
end

group :test do
  gem 'faker'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "capybara"
end