class UsersController < ApplicationController

  get '/login' do
    if
      !logged_in?
      erb :'/users/login'
    else
      #flash message needed here to acknowledge you are logged in
      redirect '/startups'
    end
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

  get '/signup' do
    erb :'/users/signup'
  end



end
