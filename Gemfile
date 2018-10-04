source 'https://rubygems.org'

ruby '2.3.3'

gem 'rails', '4.2.7'
gem 'inherited_resources', '1.6.0'
gem 'dotenv', '2.1.1'
gem 'protected_attributes', '1.1.3'
gem 'simple_form', '3.3.1'
gem 'cpf_cnpj', '0.2.1'
gem 'brstring'
gem 'paperclip', '5.1.0'
gem 'has_scope', '0.6.0'
gem 'will_paginate'
gem 'validators', '2.5.3'
gem 'enumerate_it'
gem 'i18n_alchemy'
gem 'paperclip-i18n'

# database
gem 'pg', '~> 0.20'
gem 'squeel', '1.2.3'

# server
gem 'puma', '~> 3.0'

group :assets do
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.2'
  gem 'jquery-rails', '4.2.1'
  gem 'turbolinks', '~> 5'
  gem 'jbuilder', '~> 2.5'
end

# authentication
gem 'devise', '4.2.0'

# authorization
gem 'cancan', git: 'https://github.com/ryanb/cancan.git', branch: '2.0'

group :development, :test do
  gem 'pry'
end

# correios
gem 'correios-cep', '0.6.7'

group :development do
  gem 'spring', '1.7.2' # runs app faster in dev by keeping app running in background
  gem 'spring-watcher-listen', '2.0.0'
  gem 'bullet', '5.3.0'
  gem 'quiet_assets', '1.1.0'
  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
end

group :test do
  gem 'rspec-rails', '3.5.2'
  gem 'shoulda-matchers', '3.1.1'
  gem 'factory_girl_rails', '4.7.0'
  gem 'capybara', '2.8.0'
  gem 'database_cleaner', '1.5.3'
  gem 'poltergeist', '1.10.0'
  gem 'shoulda-callback-matchers', '1.1.4'
end

group :production do
  gem 'rails_12factor'
end
