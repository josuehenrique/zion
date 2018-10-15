class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.smtp_username
  layout 'mailer'

  private

  def dispatch(options = {})
    return true unless Rails.env.production?
    return true if @to.blank?

    attachments['logo.png'] = File.read("#{Rails.root}/app/assets/images/iceb.png")
    @subject = 'ZION ICEB - ' + @subject if @subject.present?
    options.merge!({ from: @from }) if @from.present?
    options.merge!({ to: @to, cc: @cc, subject: @subject })
    options.merge!({ bcc: @bcc }) if @bcc.present?

    mail(options) do |format|
      format.html { render layout: '/layouts/default_mailer' }
    end
  end
end
