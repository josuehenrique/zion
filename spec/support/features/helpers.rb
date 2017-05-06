module Helpers
  def self.included(receiver)
    receiver.let!(:current_user) do
      FactoryGirl.cache(:user)
    end
  end

  def print
    @file ||= 0
    @file += 1
    page.driver.render(@file.to_s + '.png', full: true)
  end

  def sign_in(user = current_user)
    visit root_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_button 'Entrar'
  end

  def sign_out(user = current_user)
    click_link user.name
    click_link 'Sair'
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def navigate(path)
    first, second = path.split(/ > /, 2)

    click_link first

    sleep 0.1

    return unless second

    sleep 0.1

   within(:xpath, ".//a[contains(., '#{first}')]/following-sibling::ul") do
      navigate second
    end
  end

  def within_row_list(text)
    within page.find('tr', text: text) do
      yield
    end
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :feature
end
