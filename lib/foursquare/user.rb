# -*- coding: utf-8 -*-
# Time-stamp: <2011-06-17 19:39:08 namai>
require 'httparty'

# 自分の必要なAPIのみ
module Foursquare
  module User
    include HTTParty
    base_uri "https://api.foursquare.com/"   
    
    #ユーザ情報
    def self.users (user_id, access_token, options={})
      options.merge!({:oauth_token => access_token})
      id = user_id.to_s
      case id
      when "self"
        return self.get("/v2/users/self", :query => options) 
      when /[0-9]*/
        return self.get("/v2/users/"+id, :query => options) 
      else
        raise
      end   
    end
    
    # user_id(or self), access_token 必須
    # otions -> :limit(デフォルトで100), :offset
    def self.friends (user_id, access_token, options ={})
      options.merge!({:oauth_token => access_token})
      id = user_id.to_s
      case id
      when "self"
        return self.get("/v2/users/self/friends", :query => options) 
      when /[0-9]*/
        return self.get("/v2/users/"+id+"/friends", :query => options) 
      else
        raise
      end
    end
    
    def self.checkins (user_id, access_token, options={})
      options.merge!({:oauth_token => access_token})
      id = user_id.to_s
      case id
      when "self"
        return self.get("/v2/users/self/checkins", :query => options) 
      else
        raise
      end  
    end    
  end
end
