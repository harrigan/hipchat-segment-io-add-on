require "open-uri"
require "grape"
require "sinatra"
require "rack-flash"
require "jwt"
require "mongo_mapper"
require "oauth2"
require "httparty"

configure do
  MongoMapper.setup({
    ENV["RACK_ENV"] => { "uri" => ENV["MONGO_URL"]}
  }, ENV["RACK_ENV"])
end

module SegmentIO
  class Web < Sinatra::Base
    enable :sessions
    enable :logging

    use ::Rack::Flash

    set :session_secret, ENV["SESSION_SECRET"]
  end
end

require "./lib/models/account"
require "./lib/models/action"
require "./lib/models/identify_action"
require "./lib/models/track_action"
require "./lib/models/hipchat"
require "./lib/exceptions"
require "./lib/api"
require "./lib/web"
