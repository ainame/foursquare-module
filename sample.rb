# -*- coding: utf-8 -*-
require 'sinatra'
require 'json'
require_relative 'lib/foursquare-module'

configure do
  set :sessions, true
end

Options = {
  :client_id     => ClientId,
  :client_secret => ClientSecret,
  :redirect_uri  => RedirectUri
}

#ログインすると自分自身のユーザー情報が表示されるだけ
#各APIはだいたいaccees tokenが必要
get '/' do 
  if session[:access_token] != nil
    erb %{
<%= #{Foursquare::User.users("self",session[:access_token])} %>
}
  else
    "<a href='/oauth'>Login</a>"
  end
end

get '/oauth' do
  #Foursquare::Authenticate.configure使ってハッシュで
  #client_id, client_secret, redirect_uriを読み込ませる
  Foursquare::Authenticate.configure(Options)  
  #ユーザーを認証ページに飛ばす
  redirect Foursquare::Authenticate.authorize_uri
end

get '/oauth_callback' do
  #JSONで返って来るのでパースしてaccess tokenをセッションに入れて使う
  response = JSON.parse(Foursquare::Authenticate.get_access_token(params[:code]).body)
  session[:access_token] = response["access_token"]
  redirect '/'
end
