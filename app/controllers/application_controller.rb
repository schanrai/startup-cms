require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
  end

  get "/" do
    erb :start
  end

#this is living here because it is not being detected in the startup_profiles controller
  post '/startups/:id/addmentor' do
    s = current_startup(params[:id])
    if session[:id] != s.user_id
      s.mentor_id = session[:id]
      s.save
      flash[:message] = "You have been assigned as a mentor to #{s.name}"
      redirect "/startups/#{params[:id]}"
    else
      flash[:errors] = "You cannot mentor a startup that you submitted."
     redirect "/startups"
    end
  end

  helpers do

    def logged_in?
      !!session[:id]
    end

    def current_user
    @current_user ||= User.find(session[:id])
    #memoization
    end

    def authorized_to_edit?(id)
      id.to_i == current_user.id
    end

    def has_mentor?(startup)
      !!startup.mentor_id && startup.mentor_id != 0
    end

    def current_startup(id)
      @current_startup ||= StartupProfile.find(id)
    end


  end


end
