class BirthdayWatcherWorker
  include Sidekiq::Worker

  def perform()
    current_time = Time.now
    # Add 7 days to the current day
    birthday_time = current_time + 604800
    formating_birthday_time = "#{birthday_time.day}.#{birthday_time.month}"

    users = User.where("profile ->> 'birthday' LIKE ''#{formating_birthday_time}'%'")

  end
end