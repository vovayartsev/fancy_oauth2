module FancyOauth2 
  
  class Config
    attr_accessor :client_id, :client_secret, :site, :authorize_url, :token_url, :default_options

    def initialize
      @default_options = {}
    end

    def valid?
      res = client_id.present?
      res &&= client_secret.present? 
      res &&= site.present? 
      res &&= authorize_url.present?
      res &&= token_url.present?
    end

    def build_default_options(argument)
      {}.tap do |result|
        @default_options.each do |key, value|
          result[key] = value.respond_to?(:call) ? value.call(argument) : value
        end
      end
    end

    # TODO - introduce strategies, e.g. GoogleStrategy
    def client
      @client ||= OAuth2::Client.new(
        client_id,
        client_secret,
        :site => site,
        :authorize_url => authorize_url,
        :token_url => token_url
      )
    end
  end

end

