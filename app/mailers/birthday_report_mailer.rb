class BirthdayReportMailer < ApplicationMailer
  def send_weekly_report
    @to = ['pastorpaulochaves@gmail.com', 'familiacubala@gmail.com']
    @bcc = 'josuehenriqueferreira@gmail.com'
    @subject = 'Aniversariantes Da Semana'
    sunday = (DateTime.current.at_beginning_of_week - 1).day
    saturday = (DateTime.current.at_beginning_of_week + 5).day
    @congregateds = collection(Congregated, sunday, saturday)
    @members = collection(Member, sunday, saturday)

    dispatch
  end

  def send_daily_report
    @to = ['pastorpaulochaves@gmail.com', 'familiacubala@gmail.com']
    @bcc = 'josuehenriqueferreira@gmail.com'
    @subject = 'Aniversariantes De Hoje'
    current_day = Date.current.day
    @congregateds = collection(Congregated, current_day, current_day)
    @members = collection(Member, current_day, current_day)

    dispatch
  end

  private

  def collection(klass, start_day, end_day)
    klass.
      where("to_char(birth_dt, 'MM') = '#{Date.current.month}' and to_char(birth_dt, 'dd')::integer between #{start_day} and #{end_day}").
      order(:name)
  end
end
