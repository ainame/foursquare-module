# -*- coding: utf-8 -*-
require 'httparty'

module Foursquare
  module Venue
    include HTTParty
    base_uri "https://api.foursquare.com/"
    
    #べニューの情報取得
    def self.venues (venue_id, access_token, options={})
      options.merge!({:oauth_token => access_token})
      id = venue_id.to_s
      case id
      when /[0-9]*/
        return self.get("/v2/venues/"+id, :query => options)
      else
        raise "No Support venue_id => #{id}}"
      end   
    end

    #動作未確認
    def self.explore (ll, access_token, options={})
      options.merge!({:oauth_token => access_token, :ll => ll.to_s})
      self.get("/v2/venues/explore", :query => options) 
    end
    
    #動作未確認
    def self.search (ll, access_token, options={})
      options.merge!({:oauth_token => access_token, :ll => ll.to_s})
      self.get("/v2/venues/search", :query => options) 
    end
  end
end
