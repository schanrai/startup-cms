class MentorsController < ApplicationController

  get '/mentors' do
    @users = User.all
    erb :'/mentors/index'
  end

  get '/mentors/new' do
    @user = current_user
    if !@user.blank?
      erb :'/mentors/new'
    else
      redirect '/'
    end
  end


end
