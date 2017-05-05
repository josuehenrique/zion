require 'unit_helper'
require 'spec_helper'
require 'capybara/session'
Dir[Rails.root.join("spec/support/features/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end
