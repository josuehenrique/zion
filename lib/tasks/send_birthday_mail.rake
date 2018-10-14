namespace :send_birthday_mail do
  desc 'Send mail with daily birthdays'
  task daily_birthday_report: :environment do
    BirthdayReportMailer.send_daily_report.deliver
  end

  desc 'Send mail with weekly birthdays'
  task weekly_birthday_report: :environment do
    return unless Date.current.saturday?
    BirthdayReportMailer.send_weekly_report.deliver
  end
end
