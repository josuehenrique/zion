module Concerns
  module DefaultMailer
    extend ActiveSupport::Concern

    included do
      default from: ENV['SMTP_USERNAME']
      before_action :set_layout_mail
    end

    private

    def dispatch(options = {})
      return true unless Rails.env.production?
      return true if @to.blank?

      attachments['logo.png'] =
        File.open("#{Rails.root}/app/assets/images/iceb.png")

      options.merge!({ from: @from }) if @from.present?
      options.merge!({ to: @to, cc: @cc, subject: @subject })

      mail(options) do |format|
        format.html { render layout: "/layouts/#{@layout}" }
      end.deliver
    end

    def set_layout_mail
      @layout = 'default_mailer'
    end
  end
end
