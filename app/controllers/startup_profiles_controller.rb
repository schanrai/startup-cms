class StartupProfilesController < ApplicationController

  get '/startups' do
    if logged_in?
      @user = current_user
      @startups = StartupProfile.all
      erb :'/startups/index'
    else
      flash[:message] = "You must be logged in to view startups"
      redirect '/'
    end
  end


  get '/startups/new' do
    @user = current_user if logged_in?
    if @user
      erb :'/startups/new'
    else
      flash[:errors] = "You must be logged in to create a startup profile"
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
      flash[:errors] = "You can only edit a profile that you have created."
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
