class StartupProfilesController < ApplicationController

  get '/startups' do
    @user = current_user if logged_in?
    @startups = StartupProfile.all
    erb :'/startups/index'
  end


  get '/startups/new' do
    @user = current_user if logged_in?
    if @user
      erb :'/startups/new'
    else
      redirect '/'
    end
  end

  post '/startups' do
    if !!current_user && !params.blank?
      @startup = StartupProfile.create(name: params[:name],
        user_id: current_user.id, description: params[:description],
        year_founded: params[:year_founded],website: params[:website],
        stage: params[:stage], help_needed: params[:help_needed])
      redirect "/startups/#{@startup.id}"
    else
      redirect '/startups/new'
    end
  end


  get '/startups/:id' do
    @user = current_user if logged_in?
    @startup = StartupProfile.find(params[:id])
    erb :'/startups/show'
  end



  post '/startups/:id/addmentor' do
    #add logic to prevent the user that created the startup from becoming a mentor
    s = current_startup(params[:id])
    s.mentor_id = params[:mentor_id]
    s.save
    #flash message "you have successfully been assigned to mentor Startup X"
    redirect "/startups/#{params[:id]}"
  end




end
