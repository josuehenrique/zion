require 'capybara/rspec'
require 'capybara/poltergeist'

module Capybara
  module Node
    class Base
      # Finds a link by id or text and clicks it. Also looks at image alt text inside the link.
      #
      # You can confirm a javascript dialog using the confirm option:
      #
      #   click_link 'Destroy', confirm: true
      def click_link(locator, options = {})
        confirm = options.delete(:confirm)

        if confirm
          driver.execute_script 'this._confirm = this.confirm'
          driver.execute_script 'this.confirm = function () { return true }'
        end

        super(locator)

        if confirm
          driver.execute_script 'this.confirm = this._confirm'
        end
      end
    end
  end
end

Capybara.configure do |config|
  config.default_driver = :poltergeist
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    js_errors: true,
    phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes'],
    timeout: 120,
    window_size: [1280, 800]
  })
end
