namespace :nginx do
  desc 'Reload nginx configuration'
  task :reload do
    on roles(:web) do
      sudo 'service nginx reload'
    end
  end
end
