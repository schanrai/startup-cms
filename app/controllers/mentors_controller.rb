class MentorsController < ApplicationController


  get '/mentors' do
    set_user
    @users = User.all
    erb :'/mentors/index'
  end


  get '/mentors/new' do
    @user = current_user
    if @user && @user.mentor_description.blank?
      erb :'/mentors/new'
    else
      redirect '/mentors'
    end
  end


  post '/mentors' do
    #redirect_if_not_logged_in
    set_user
    if params[:mentor_description] != ""
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
    @mentor = User.find(params[:id])
    erb :'/mentors/show'
  end


  get '/mentors/:id/edit' do
    set_user
    if authorized_to_edit?(params[:id])
      erb :'/mentors/edit'
    else
      redirect '/mentors'
    end
  end


  patch '/mentors/:id' do
    set_user
    if params != ""
    # 2. modify (update) the journal entry
      @user.update(name: params[:name],mentor_description: params[:mentor_description], location: params[:location], linked_in: params[:linked_in])
      # 3. redirect to show page
      @user.save!(validate: false)
      redirect "/mentors/#{@user.id}"
    else
      redirect "mentors/#{current_user.id}/edit"
    end
  end

  



private

  def set_user
    @user = User.find(session[:id])
  end

end
