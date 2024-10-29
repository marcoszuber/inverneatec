# config/schedule.rb
every 3.hours do
  rake 'scrape:agrositio'
end
every 1.day, at: '9:00 am' do
  rake "contracts:notify_expiring"
end
