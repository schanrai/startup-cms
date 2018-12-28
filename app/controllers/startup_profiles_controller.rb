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
      flash[:message] = "You must be logged in to create a startup profile"
      redirect '/'
    end
  end


  post '/startups' do
    if !!current_user && !params.blank?
      @startup = StartupProfile.create(name: params[:name],
        user_id: current_user.id, description: params[:description],
        year_founded: params[:year_founded],website: params[:website],
        stage: params[:stage], help_needed: params[:help_needed])
      flash[:message] = "Startup profile successfully created." if @startup.description
      redirect "/startups"
    else
      flash[:errors] =  @user.errors.full_messages.to_sentence
      redirect '/startups/new'
    end
  end



  get '/startups/:id' do
    @user = current_user if logged_in?
    @startup = StartupProfile.find(params[:id])
    erb :'/startups/show'
  end


  get '/startups/:id/edit' do
    @user = current_user
    @startup = current_startup(params[:id])
    if authorized_to_edit?(@startup.user_id)
      erb :'/startups/edit'
    else
      flash[:message] = "You can only edit a profile that you have created."
      redirect '/startups'
    end
  end


  patch '/startups/:id' do
    @startup = current_startup(params[:id])
    if @startup
      @startup.update(name: params[:name],
        description: params[:description],
        year_founded: params[:year_founded],website: params[:website],
        stage: params[:stage], help_needed: params[:help_needed])
        @startup.save
        flash[:message] = "Profile updated successfully."
        redirect "/startups/#{@startup.id}"
    else
      flash[:errors] = "Something went wrong: #{@startup.errors.full_messages.to_sentence}"
      redirect "/startups/#{@startup.id}/edit"
    end


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


  delete '/startups/:id' do
    @startup = current_startup(params[:id])
    if authorized_to_edit?(@startup.user_id)
      @startup = current_startup(params[:id])
      @startup.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect '/startups'
    else
      flash[:errors] = "Something went wrong: #{@user.errors.full_messages.to_sentence}"
      redirect "/startups/#{@startup.id}"
      end
    end
  end



end
