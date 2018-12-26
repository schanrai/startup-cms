class MentorsController < ApplicationController


  get '/mentors' do
    @user = current_user if logged_in?
    @users = User.all
    erb :'/mentors/index'
  end


  get '/mentors/new' do
    @user = current_user if logged_in?
    if @user && @user.mentor_description.blank?
      erb :'/mentors/new'
    else
      redirect '/mentors'
    end
  end


  post '/mentors' do
    #redirect_if_not_logged_in
    #@user = current_user
    if !!current_user && params[:mentor_description] != ""
      @user = current_user
      @user.update(mentor_description: params[:mentor_description], location: params[:location], linked_in: params[:linked_in])
      @user.save!(validate: false)
      #flash[:message] = "Journal entry successfully created." if @journal_entry.id
      #redirect "/journal_entries/#{@journal_entry.id}"
      redirect '/mentors'
    else
      #flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/mentors/new'
    end
  end


  get '/mentors/:id' do
    @user = User.find(params[:id])
    erb :'/mentors/show'
  end


  get '/mentors/:id/edit' do
    @user= current_user
    if authorized_to_edit?(params[:id])
      erb :'/mentors/edit'
    else
      redirect '/mentors'
    end
  end


  patch '/mentors/:id' do
    @user = current_user
    if params[:mentor_description] != ""
    # 2. modify (update) the journal entry
      @user.update(name: params[:name],mentor_description: params[:mentor_description], location: params[:location], linked_in: params[:linked_in])
      # 3. redirect to show page
      @user.save!(validate: false)
      redirect "/mentors/#{@user.id}"
    else
      #redirect "mentors/#{current_user.id}/edit"
      redirect "/"
    end
  end


  delete '/mentors/:id' do
    if authorized_to_edit?(params[:id])
    @user = current_user
    @user.destroy
    session.clear
    #flash[:message] = "Successfully deleted that entry."
    redirect '/'
  else
    redirect '/mentors/:id'
    end
  end



private



end
