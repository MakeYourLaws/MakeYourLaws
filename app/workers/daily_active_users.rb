class DailyActiveUsers
  @queue = :active_users

  def self.process # args
    dau = User.where(updated_at: (Time.now.midnight - 1.day)..Time.now.midnight).count
    day = Date.today - 1
    AdminMailer.dau(day, dau).deliver
  end

end