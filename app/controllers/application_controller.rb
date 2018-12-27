require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :start
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
      !!startup.mentor_id
    end

    def current_startup(id)
      @current_startup ||= StartupProfile.find(id)
    end


  end


end
