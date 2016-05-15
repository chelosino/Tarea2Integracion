require 'sinatra'
require 'json'
require 'open-uri'

get '/' do
	return 'Hello World!'
end

get '/hola' do
	return 'chao'
end

post '/instagram/tag/buscar' do
	tag = params['tag']
	access_token = params['access_token']

	if not params['tag'] or not params['access_token']
		return status 400
	end

	begin
		status = 200
		headers["Content-Type"] = 'application/json;charset=utf-8'
		datos = open('https://api.instagram.com/v1/tags/' + tag + '/media/recent?access_token=' + access_token + '').read
		datos1 = open('https://api.instagram.com/v1/tags/' + tag + '?access_token=' + access_token + '').read
		commit = open('https://api.github.com/repos/chelosino/Tarea2Integracion/git/refs/heads/master').read
		#datos1 = File.read('../prueba1.json')
		datos1_hash = JSON.parse(datos1)
		total = datos1_hash['data']['media_count'].to_s
		commit_hash = JSON.parse(commit)
		url = commit_hash['object']['url']
		commit1 = open(url).read
		commit1_hash = JSON.parse(commit1)
		version = commit1_hash['message'].to_s
		#datos = File.read('../prueba.json')
		datos_hash = JSON.parse(datos)
		result = {'metadata' => {'total' => total}, 'posts' => [], 'version' => version}

		for i in 0..19
			result['posts'] << {'tags' => [], 'username' => '', 'likes' => ''.to_i, 'url' => '', 'caption' => ''}

			tags = datos_hash['data'][i]['tags']
			tags.each do |tag|
				result['posts'][i]['tags'] << tag
			end
		
			user = datos_hash['data'][i]['user']
			result['posts'][i]['username'] << user['username']
		
			likes = datos_hash['data'][i]['likes']
			result['posts'][i]['likes'] = likes['count'].to_i
		
			images = datos_hash['data'][i]['images']
			standard = images['standard_resolution']
			result['posts'][i]['url'] << standard['url']

			caption = datos_hash['data'][i]['caption']
			result['posts'][i]['caption'] = caption['text']
		end
		return result.to_json
	end
end