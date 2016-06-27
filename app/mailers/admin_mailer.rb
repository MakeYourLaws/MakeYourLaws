class AdminMailer < ActionMailer::Base
  # include Resque::Mailer

  default to: -> { 'MYL Core <core@makeyourlaws.org>' }

  def dau date
    @date = date.to_date
    @dau = User.dau(@date).count
    @usercount = User.count
    mail(subject: 'MYL DAU')
  end
end
