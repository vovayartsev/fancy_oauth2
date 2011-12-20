require 'fancy_oauth2/version'

require 'haml-rails'
require 'oauth2'

require 'fancy_oauth2/rails/engine'
require 'fancy_oauth2/rails/railtie'

require 'fancy_oauth2/config'

ActionController::Base.class_eval do
  helper :fancy_oauth2
end

module FancyOauth2
  def self.config
    @config ||= Config.new
  end

  def self.client
    raise "fancy_oauth2: not configured" unless config.valid?
    config.client
  end

  def self.configure
    yield(config)
  end

  def self.authorize_url(options = {}, builder_argument = nil)
    default_options = config.build_default_options(builder_argument)
    default_options.merge!(options) if options
    client.auth_code.authorize_url default_options
  end

  def self.callback_url_builder
    lambda{ |request|
      host_and_port = request.host
      host_and_port += ":#{request.port}" if request.port and request.port.to_i != 80
      result = "#{request.protocol}#{host_and_port}/fancy_oauth2/callback"
    }
  end

end
