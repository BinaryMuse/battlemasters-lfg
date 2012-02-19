namespace :app do
  desc "Delete listings more than an hour old"
  task :delete_old_listings => :environment do
    Listing.where("created_at < ?", 1.hour.ago).destroy_all
  end
end
