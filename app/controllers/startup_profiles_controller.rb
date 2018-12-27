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
      redirect "/startups"
    else
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
      #flash message?
      redirect '/startups'
    end
  end


  patch '/startups/:id' do
    #@user = current_user
    @startup = current_startup(params[:id])
    # 2. modify (update) the journal entry
    @startup.update(name: params[:name],
    description: params[:description],
    year_founded: params[:year_founded],website: params[:website],
    stage: params[:stage], help_needed: params[:help_needed])
      # 3. redirect to show page
    @startup.save
    redirect "/startups/#{@startup.id}"
    end


  post '/startups/:id/addmentor' do
    #add logic to prevent the user that created the startup from becoming a mentor
    s = current_startup(params[:id])
    if session[:id] != s.user_id
      s.mentor_id = params[:mentor_id]
      s.save
    #flash message "you have successfully been assigned to mentor Startup X"
      redirect "/startups/#{params[:id]}"
    else
      #flash message to say you cannot mentor your own startup
     redirect "/startups/#{params[:id]}/edit"
   end
  end


  delete '/startups/:id' do
    @startup = current_startup(params[:id])
    if authorized_to_edit?(@startup.user_id)
    @startup = current_startup(params[:id])
    @startup.destroy
    #flash[:message] = "Successfully deleted that entry."
    redirect '/startups'
  else
    redirect "/startups/#{@startup.id}"
    end
  end



end
