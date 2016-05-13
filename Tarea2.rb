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
		#datos = open('https://api.instagram.com/v1/tags/' + tag + '/media/recent?access_token=' + access_token + '')
		#datos1 = open('https://api.instagram.com/v1/tags/' + tag + '?access_token=' + access_token + '')
		datos1 = File.read('../prueba1.json')
		datos1_hash = JSON.parse(datos1)
		total = datos1_hash['data']['media_count'].to_s
		datos = File.read('../prueba.json')
		datos_hash = JSON.parse(datos)
		#tags = ''
		#datos_hash['data'].each do |tag|
		#	tags = tags + ',' + tag['tags']
		#end
		result = {'metadata' => {'total' => total}, 'posts' => [{'tags' => []}, {'username' => ''}, {'likes' => ''}, {'url' => ''}, {'caption' => ''}], 'version' => '1.0.0'}
		#{'tags' => []}
		#datos_hash['data'].each do |item|
		#	tags = item['tags']
		#	tags.each do |tag|
		#		result['posts']['tags'] << tag
		#	end
		#end
		#result['posts']['tags'] << 'hola'
		#result['posts']['tags'] << 'chao'
		return result.to_json
	end
end