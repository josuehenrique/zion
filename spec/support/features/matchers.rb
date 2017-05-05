module Matchers
  extend RSpec::Matchers::DSL

  matcher :have_primary do |notice|
    match do |page|
      expect(page).to have_css(".alert-primary", text: notice)
    end

    failure_message do |page|
      "expected #{page.text.inspect} to have primary #{notice.inspect}"
    end

    failure_message_when_negated do |page|
      "expected #{page.text.inspect} not to have primary #{notice.inspect}"
    end
  end

  matcher :have_success do |notice|
    match do |page|
      expect(page).to have_css(".alert-success", text: notice)
    end

    failure_message do |page|
      "expected #{page.text.inspect} to have success #{notice.inspect}"
    end

    failure_message_when_negated do |page|
      "expected #{page.text.inspect} not to have success #{notice.inspect}"
    end
  end

  matcher :have_alert do |alert|
    match do |page|
      expect(page).to have_css(".alert-alert", text: alert)
    end

    failure_message do |page|
      "expected #{page.text.inspect} to have alert #{alert.inspect}"
    end

    failure_message_when_negated do |page|
      "expected #{page.text.inspect} not to have alert #{alert.inspect}"
    end
  end

  matcher :have_info do |info|
    match do |page|
      expect(page).to have_css(".alert-info", text: info)
    end

    failure_message do |page|
      "expected #{page.text.inspect} to have info #{info.inspect}"
    end

    failure_message_when_negated do |page|
      "expected #{page.text.inspect} not to have info #{info.inspect}"
    end
  end

  matcher :have_warning do |warning|
    match do |page|
      expect(page).to have_css(".alert-warning", text: warning)
    end

    failure_message do |page|
      "expected #{page.text.inspect} to have warning #{warning.inspect}"
    end

    failure_message_when_negated do |page|
      "expected #{page.text.inspect} not to have warning #{warning.inspect}"
    end
  end
end

RSpec.configure do |config|
  config.include Matchers, type: :feature
end
