class FollowSleepQuery
  def initialize(user:)
    @user = user
  end

  def following_previous_week_sleeps
    @user.following
         .joins(:sleeps)
         .where('sleep_at >= ?', Date.current - 7.days)
         .select(sleep_select)
         .order('sleeps.duration DESC')
  end

  def sleep_select
    <<-SQL.squish
      users.*,
      sleeps.sleep_at,
      sleeps.wake_at,
      sleeps.duration AS sleep_duration
    SQL
  end
end