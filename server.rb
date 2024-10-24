require 'sinatra'
require 'pry'
require 'json'
require_relative 'helpers/gitlab_service'

Tilt.register Tilt::ERBTemplate, 'html.erb'
set :port, 4000
set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/users' do
  erb :users, locals: { users: GitlabService.list_users }
end

get '/mr' do
  erb :mr, locals: { merge_request: GitlabService.fetch_sample_merge_request }
end

get '/mrs' do
  merge_requests = GitlabService.fetch_merge_requests
  sorted_merge_requests = merge_requests.sort_by { |mr| mr.created_at }.reverse
  erb :mrs, locals: { merge_requests: sorted_merge_requests }
end

get '/mr.json' do
  GitlabService.fetch_sample_merge_request.to_hash.to_json
end

get '*' do
  'Not found'
end
