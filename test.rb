ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'coveralls'
require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
require_relative 'Tarea2.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Tarea2" do

  it "should return Hello World!" do
    get '/'
    info = 'Hello World!'
    info.must_equal last_response.body
  end
  
  it "should return json" do
    post '/instagram/tag/buscar?tag=santiago&access_token=2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  end 
  
  it "should retun 200" do
    post '/instagram/tag/buscar?tag=santiago&access_token=2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    status = 200
    status.must_equal last_response.status
  end

  it "should return 400" do
    post '/instagram/tag/buscar'
    status = 400
    status.must_equal last_response.status
  end

  it "should retun chao" do
    get '/hola'
    info = 'chao'
    info.must_equal last_response.body
  end

  Coveralls.wear!

end
