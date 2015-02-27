require 'sinatra/base'
require 'json'
require 'fileutils'
require 'securerandom'

module Rack
class Chunker < Sinatra::Base

  configure :development do
    set :upload_folder, ::File.expand_path('../../tmp/dev_uploads', ::File.dirname(__FILE__))
    set :app_path, '/files'
    set :bind, '0.0.0.0'
    set :port, 1080
  end

  configure :test do
    set :upload_folder, ::File.expand_path('../../tmp/test_uploads', ::File.dirname(__FILE__))
    set :app_path, '/files'
    # set :bind, '0.0.0.0'
    # set :port, 80
  end

  def self.route_path(path='')
    app_path = settings.respond_to?(:app_path) ? settings.app_path : ''
    route_path = [app_path, path].join('')
    puts "route_path for '#{path}' : #{route_path}"
    route_path
  end

  # Generates a new (subclass) Class so that we can change the settings in a block
  def self.generate_app(&block)
    c = Class.new(self)
    puts "Created an app"
    if block_given?
      puts "Running initialization block"
      c.class_eval(&block)
    end
    c
  end

  helpers do
    def temp_file_path(filename)
      ::FileUtils.mkdir_p settings.upload_folder
      ::File.expand_path("#{filename}.tmp",settings.upload_folder)
    end

    def base_url
      base = "http://#{request.host}"
      base = request.port == 80 ? base : base << ":#{request.port}"
      base_url = base + settings.app_path
    end

    def file_url(path='')
      # path = self.class.route_path(path)
      # [base_url, path].join('')
      [base_url, path].join('/')
    end

    def halt_with_bad_request(reason)
      if request.accept?("application/json")
        result = { :error => reason }.to_json
        content_type :json
      else
        result = reason
      end
      halt 400, result
    end
  end

  error do
    status 500
    "Y U NO WORK?"
  end

  ## Tus Extension : Create File
  # Handle POST-request (Create temporary File)
  post route_path("/?") do
    # 1. Collect input

    # Guards :
    # The Entity-Length header indicates the final size of a new entity in bytes.
    # This way a server will implicitly know when a file has completed uploading.
    # The value MUST be a non-negative integer.
    entity_length = request.env.fetch("HTTP_ENTITY_LENGTH") { halt_with_bad_request("'Entity-Length' header must be sent") }
    begin entity_length = Integer(entity_length); rescue ArgumentError; halt_with_bad_request("'Entity-Length' header value MUST be a non-negative INTEGER"); end
    halt_with_bad_request("'Entity-Length' header value MUST be a non-negative INTEGER") if entity_length < 0

    unique_filename = "#{SecureRandom.hex}"
    path = temp_file_path(unique_filename)

    # 2. Perform Work
    ::File.write(path, '')

    # 3. Return result
    response.headers['Location'] = file_url(unique_filename)
    status 201
  end

end
end
