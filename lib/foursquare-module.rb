# -*- coding: utf-8 -*-
# Time-stamp: <2011-06-11 16:12:06 namai>

require_relative 'foursquare/user'
require_relative 'foursquare/venue'
require_relative 'foursquare/authenticate'
require_relative 'foursquare/checkin'

module Foursquare
  include Authenticate
  include User
  include Venue
  include Checkin
end
