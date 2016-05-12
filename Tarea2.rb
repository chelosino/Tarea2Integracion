require 'sinatra'
require 'json'
require 'open-uri'

get '/' do
	return 'Hello World!'
end

post '/instagram/tag/buscar' do
	tag = params['tag']
	access_token = params['access_token']

	if not params['tag'] or not params['access_token']
		return status 400
	end

	begin
		status = 200
		datos = open('https://api.instagram.com/v1/tags/' + tag + '/media/recent?access_token=' + access_token + '')
		return datos
	end
end