ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require 'active_support/dependencies/autoload'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

$:.unshift File.expand_path('../../', __FILE__)

# I18n
require 'i18n'
I18n.load_path += Dir['config/locales/**/*.yml']
I18n.default_locale = 'pt-BR'
I18n.enforce_available_locales = true
I18n.backend.reload!

require 'pry'
