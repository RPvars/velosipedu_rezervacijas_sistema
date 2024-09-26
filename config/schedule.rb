set :output, "log/cron_log.log"

every 1.day, at: '8:00 am' do
  rake 'reservation_reminders:send'
end