class StartupProfilesController < ApplicationController

  get '/startups' do
    @user = current_user if logged_in?
    @startups = StartupProfile.all
    erb :'/startups/index'
  end

  get '/startups/:id' do
    @startup = StartupProfile.find(params[:id])
    erb :'/startups/show'
  end





end
