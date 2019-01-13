require_relative 'boot'

require 'rails/all'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

require 'dotenv'
Dotenv.load

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Zion
  class Application < Rails::Application
    config.to_prepare do
      Devise::SessionsController.layout 'login'
      Devise::RegistrationsController.layout 'login'
      Devise::ConfirmationsController.layout 'login'
      Devise::UnlocksController.layout 'login'
      Devise::PasswordsController.layout 'login'
    end

    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/app/enumerations
      #{config.root}/app/business
    )

    # internationalization
    config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
    config.i18n.default_locale = 'pt-BR'
    I18n.enforce_available_locales = true

    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    # hide password on log
    config.filter_parameters += [:password]

    config.active_record.schema_format = :sql

    # Include helpers from current controller only
    config.action_controller.include_all_helpers = false

    config.assets.paths << Rails.root.join('app', 'assets', 'font', 'plugins')

    # mailer configurations
    config.action_mailer.delivery_method        = :smtp
    config.action_mailer.perform_deliveries     = true
    config.action_mailer.raise_delivery_errors  = true
    config.action_mailer.default charset: 'utf-8'

    config.action_mailer.smtp_settings = {
      address:              Rails.application.secrets.smtp_address,
      port:                 Rails.application.secrets.smtp_port,
      user_name:            Rails.application.secrets.smtp_username,
      password:             Rails.application.secrets.smtp_password,
      enable_starttls_auto: true,
      authentication:       :login,
      domain:               Rails.application.secrets.smtp_domain
    }
  end
end
