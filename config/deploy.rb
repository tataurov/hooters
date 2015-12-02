# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'hooters'
set :repo_url, 'git@github.com:tataurov/hooters.git'
set :pty, true

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :keep_releases, 3

