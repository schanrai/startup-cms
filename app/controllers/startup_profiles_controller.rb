class StartupProfilesController < ApplicationController

  get '/startups' do
    erb :'/startups/index'
  end


  
end
