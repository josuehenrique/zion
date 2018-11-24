source 'https://rubygems.org'

ruby '2.5.1'

gem 'rails', '5.1.6'
gem 'inherited_resources'
gem 'dotenv'
gem 'protected_attributes_continued'
gem 'simple_form'
gem 'cpf_cnpj'
gem 'brstring'
gem 'paperclip'
gem 'has_scope'
gem 'will_paginate'
gem 'validators'
gem 'enumerate_it'
gem 'i18n_alchemy'
gem 'paperclip-i18n'

# database
gem 'pg', '0.20.0'

# server
gem 'puma'

group :assets do
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'jquery-rails', '~> 4.3'
  gem 'turbolinks'
  gem 'jbuilder'
end

# authentication
gem 'devise'

# authorization
gem 'cancan', git: 'https://github.com/ryanb/cancan.git', branch: '2.0'

group :development, :test do
  gem 'pry'
end

# correios
gem 'correios-cep'

group :development do
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'shoulda-callback-matchers'
end

group :production do
  gem 'rails_12factor'
end
