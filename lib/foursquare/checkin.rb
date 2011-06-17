# -*- coding: utf-8 -*-
# Time-stamp: <2011-06-17 19:43:33 namai>
require 'httparty'

#チェックインするためのモジュール
module Foursquare  
  module Checkin
    include HTTParty
    base_uri "https://api.foursquare.com/"   
    

    # @venue_id  :ほぼ必須。shoutかvenue nameを渡す場合はいらない。
    # @broadcast :必須。どの範囲まで公開するか。(public/private/facebook/twitter)。デフォはpublic。
    # @shout     :140文字まで添付できるメッセージ。
    # (@venue)   :venue nameを文字列で渡すときにも使う。  
    def self.add(options={})
      if options[:oauth_token] == nil || options[:venue_id] == nil
        return false
      end
      len = options[:shout].length
      options[:shout].slice!(140..len) if len > 140
      options[:broadcast] ||= "puclic,facebook,twitter"
      self.post("/v2/checkins/add", :query => options)
    end
  end
end
