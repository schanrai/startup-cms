class StartupProfilesController < ApplicationController

  get '/startups' do
    @user = current_user if logged_in?
    @startups = StartupProfile.all
    erb :'/startups/index'
  end

  get '/startups/:id' do
    @user = current_user if logged_in?
    @startup = StartupProfile.find(params[:id])
    erb :'/startups/show'
  end


  post '/startups/:id/addmentor'do
    s = current_startup(params[:id])
    s.mentor_id = params[:mentor_id]
    s.save
    redirect "/startups/#{params[:id]}"
  end




end
