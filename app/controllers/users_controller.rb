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
    if
      !logged_in?
      erb :'/users/signup'
    else
      redirect '/startups'
    end
  end

  post '/signup' do
      @user = User.new(name: params[:name],email: params[:email],password: params[:password])
      if @user.save
      session[:id] = @user.id
        if !!params[:yes]
          redirect "/mentor/new"
        else
          redirect "/startups"
        end
      else
      #flash message about signup credentials being invalid, try again
      #what about if user already exists?
      redirect '/signup'
      end
  end





end
