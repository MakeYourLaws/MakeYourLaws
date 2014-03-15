class AdminMailer < ActionMailer::Base
  include Resque::Mailer

  default to: Proc.new{ Role.where(name: 'admin').first.users.select([:name, :email]).map{|u| "#{u.name} <#{u.email}>"} }

  def dau date
    @date = Date.parse(date)
    @dau = User.dau(@date).count
    @usercount = User.count
    mail(subject: 'MYL DAU')
  end
end