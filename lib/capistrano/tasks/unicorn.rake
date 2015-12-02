namespace :unicorn do
  %w{addworker delworker restart upgrade reload force-stop reopen-logs}.each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:app) do
        execute "sudo service unicorn_hooters #{command}"
      end
    end
  end
end