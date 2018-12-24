class MentorsController < ApplicationController

  get '/mentors' do
    @users = User.all
    erb :'/mentors/index'
  end



end
