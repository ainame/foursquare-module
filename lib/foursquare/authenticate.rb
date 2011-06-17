# -*- coding: utf-8 -*-
# Time-stamp: <2011-06-17 19:34:56 namai>

require 'rubygems'
require 'httparty'
require 'uri'

module Foursquare
  module Authenticate
    include HTTParty
    base_uri 'https://api.foursquare.com/'
    
    OPTION_KEYS = [:id,
                   :client_id,
                   :client_secret,
                   :redirect_uri].freeze    
    attr_accessor *OPTION_KEYS
    
    def self.configure (options={ })
      @client_id     = options[:client_id]
      @client_secret = options[:client_secret]
      @redirect_uri  = options[:redirect_uri]      
      true
    end
    
    def self.authorize_uri (options={ })
      options = {
        :client_id => @client_id,
        :response_type => "code",
        :redirect_uri  => @redirect_uri
      }
      "https://foursquare.com/oauth2/authenticate?"+hash_to_query(options)
    end
    
    def self.get_access_token (code)
      options = {
        :client_id => @client_id,
        :client_secret => @client_secret,
        :redirect_uri  => @redirect_uri,
        :grant_type => "authorization_code",
        :code => code
      }
      uri = "https://foursquare.com/oauth2/access_token?" + self.hash_to_query(options)
      self.get(uri)
    end
    
    def self.hash_to_query(options={})
      Array(options).map do |k, v|
        URI.encode(k.to_s + "=" + v.to_s)
      end.join("&")      
    end
    
  end
end

