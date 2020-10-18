source "https://rubygems.org"

ruby "2.5.1"

gem "rails", "5.1.6"
gem "inherited_resources", "1.11.0"
gem "dotenv", "2.5.0"
gem "protected_attributes_continued", "1.5.0"
gem "simple_form", "4.0.1"
gem "cpf_cnpj", "0.5.0"
gem "brstring", "3.3.0"
gem "paperclip", "6.1.0"
gem "has_scope", "0.7.2"
gem "will_paginate", "3.1.6"
gem "validators", "2.8.0"
gem "enumerate_it", "1.7.0"
gem "i18n_alchemy", "0.3.1"
gem "paperclip-i18n", "4.3.0"
gem "faker", "1.9.1"

# database
gem "pg", "0.20.0"

# server
gem "puma", "3.12.0"

group :assets do
  gem "uglifier", "4.1.19"
  gem "coffee-rails", "4.2.2"
  gem "jquery-rails", "~> 4.3"
  gem "turbolinks", "5.2.0"
  gem "jbuilder", "2.7.0"
end

# authentication
gem "devise", "4.5.0"

# authorization
gem "cancan", git: "https://github.com/ryanb/cancan.git", branch: "2.0"

group :development, :test do
  gem 'annotate' , '~> 2.7.3'
  gem "pry", "0.11.3"
end

# correios
gem "correios-cep", "0.8.0"

group :development do
  gem "spring", "2.0.2"
  gem "spring-watcher-listen", "2.0.1"
  gem "bullet", "5.7.6"
  gem "better_errors", "2.5.0"
  gem "binding_of_caller", "0.8.0"
end

group :test do
  gem "rspec-rails", "3.8.0"
  gem "shoulda-matchers", "3.1.2"
  gem "factory_girl_rails", "4.9.0"
  gem "capybara", ">= 2.1"
  gem "database_cleaner", "1.7.0"
  gem "poltergeist", "1.18.1"
  gem "shoulda-callback-matchers", "1.1.4"
end

group :production do
  gem "rails_12factor", "0.0.3"
end
