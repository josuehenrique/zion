ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'paperclip/matchers'

Dir[Rails.root.join("spec/support/common/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = true

  config.mock_with :rspec

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # filtering by tags
  if ENV['FILTER_TAGS']
    config.filter_run_excluding intermittent: true
  end

  config.include Paperclip::Shoulda::Matchers

  config.include FactoryGirl::Syntax::Methods
end
