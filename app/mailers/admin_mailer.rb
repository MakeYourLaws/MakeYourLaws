class AdminMailer < ActionMailer::Base
  include Resque::Mailer

  admin_role = Role.where(name: 'admin').first
  default to: -> { admin_role.users.select([:name, :email]).map { |u| "#{u.name} <#{u.email}>" } }

  def dau date
    @date = Date.parse(date)
    @dau = User.dau(@date).count
    @usercount = User.count
    mail(subject: 'MYL DAU')
  end
end
