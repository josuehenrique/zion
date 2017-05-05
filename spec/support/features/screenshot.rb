RSpec.configure do |config|
  config.add_setting :screenshot_on_errors, default: ENV['SS']

  config.before(:suite) do
    if config.screenshot_on_errors
      FileUtils.rm_rf "tmp/errors"
      FileUtils.mkdir_p "tmp/errors"
    end
  end

  config.after(:each, type: :features) do
    if example.exception && config.screenshot_on_errors
      file_name = example.description.parameterize.underscore

      page.save_screenshot "tmp/errors/#{file_name}.png", full: true
    end
  end
end
