class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if
      user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/startups'
    else
      #flash message needed here on faiure
      redirect '/login'
    end
  end



end
