class UsersController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/startups'
    end
  end


  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/startups'
    else
      flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
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
        if params[:setup] == "yes"
          redirect "/mentors/new"
        else
          redirect "/startups"
        end
      else
        flash[:errors] =  @user.errors.full_messages.to_sentence
      redirect '/signup'
      end
    end


      get '/logout' do
        session.clear
        redirect '/'
      end



end
