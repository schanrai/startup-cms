class StartupProfilesController < ApplicationController

  get '/startups' do
    @user = current_user if logged_in?
    @startups = StartupProfile.all
    erb :'/startups/index'
  end





end
