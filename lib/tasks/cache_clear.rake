namespace :cache do
  desc 'Clear application cache'
  task :clear => :environment do
    Rails.cache.clear
  end
end