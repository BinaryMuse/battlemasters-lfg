every 15.minutes do
  rake "app:delete_old_listings"
end

every 1.day, at: '12:00 am' do
  rake "app:update_servers"
end
