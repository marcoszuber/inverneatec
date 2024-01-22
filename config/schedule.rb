# config/schedule.rb
every 3.hours do
  rake 'scrape:agrositio'
end
