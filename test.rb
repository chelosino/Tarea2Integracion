ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'coveralls'
require_relative 'Tarea2.rb'

include Rack::Test::Methods

Coveralls.wear!

def app
  Sinatra::Application
end

describe "Tarea2" do

  #it "should return the factors of 6" do
  #  6.factors.must_equal [1,2,3,6]
  #end
#
  #it "should say that 2 is prime" do
  #  assert 2.prime?
  #end
#
  #it "should say that 10 is not prime" do
  #  refute 10.prime?
  #end
#
  #it "should return json" do
  #  get '/6'
  #  last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  #end 
#
  #it "should return the correct info about 6 as json" do
  #  get '/6'
  #  six_info = { number: 6, factors: 6.factors, odd: 6.odd?, even: 6.even?, prime: 6.prime? }
  #  six_info.to_json.must_equal last_response.body
  #end

  it "should retun 200" do
    post "/"
    status = 200
    status.must_equal last_response.status
  end

  it "should return 400" do
    post "/instagram/tag/buscar"
    status = 400
    status.must_equal last_response.status
  end

  it "should retun chao" do
    get '/hola'
    info = 'chao'
    info.must_equal last_response.body
  end

end