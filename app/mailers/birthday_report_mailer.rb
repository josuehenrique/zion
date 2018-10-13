class BirthdayReportMailer < ApplicationMailer
  def send_weekly_report
    @to = ['pastorpaulochaves@gmail.com', 'familiacubala@gmail.com']
    @bcc = 'josuehenriqueferreira@gmail.com'
    @subject = 'Birthday weekly report'
    sunday = (DateTime.current.at_beginning_of_week - 1).day
    saturday = (DateTime.current.at_beginning_of_week + 5).day
    @congregateds = congregateds(sunday, saturday)
    @members = members(sunday, saturday)

    dispatch
  end

  def send_daily_report
    @to = ['pastorpaulochaves@gmail.com', 'familiacubala@gmail.com']
    @bcc = 'josuehenriqueferreira@gmail.com'
    @subject = 'Birthday daily report'
    current_day = Date.current.day
    @congregateds = congregateds(current_day, current_day)
    @members = members(current_day, current_day)

    dispatch
  end

  private

  def congregateds(start_day, end_day)
    Congregated.
      where("to_char(birth_dt, 'MM') = '#{Date.current.month}' and to_char(birth_dt, 'dd')::integer between #{start_day} and #{end_day}").
      order(:name)
  end

  def members(start_day, end_day)
    Member.
      where("to_char(birth_dt, 'MM') = '#{Date.current.month}' and to_char(birth_dt, 'dd')::integer between #{start_day} and #{end_day}").
      order(:name)
  end
end
