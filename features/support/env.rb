ENV['RACK_ENV'] = 'test'

require 'rack/test'
require "json_spec/cucumber"
require File.join(File.dirname(__FILE__), '..', '..', 'lib/rack/chunker')

module AppHelper
  # Rack-Test expects the app method to return a Rack application
  def app
    @my_app ||= Rack::Chunker.generate_app do
      set :upload_folder, ::File.expand_path('../../tmp/test_uploads', ::File.dirname(__FILE__))
      # set :app_path, '/files'
    end
    puts "app_path : #{@my_app.app_path}"
    @my_app
  end

  def last_json
    last_response.body
  end
end

World(Rack::Test::Methods)
World(AppHelper)
