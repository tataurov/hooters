load 'lib/capistrano/tasks/nginx.rake'
load 'lib/capistrano/tasks/unicorn.rake'

namespace :deploy do
  after :publishing, 'nginx:reload'
  after :publishing, 'unicorn:upgrade'
end
