class MentorsController < ApplicationController


  get '/mentors' do
    if logged_in?
      @user = current_user
      @users = User.all
      erb :'/mentors/index'
    else
      flash[:message] = "You must be logged in to view Mentors"
      redirect '/'
    end
  end


  get '/mentors/new' do
    @user = current_user if logged_in?
    if @user && @user.mentor_description.blank?
      erb :'/mentors/new'
    else
      flash[:message] = "Mentor profile already exists" if !!@user.mentor_description
      redirect '/mentors'
    end
  end


  post '/mentors' do
    if !!current_user && params[:mentor_description] != ""
      @user = current_user
      @user.update(mentor_description: params[:mentor_description], location: params[:location], linked_in: params[:linked_in])
      @user.save!(validate: false)
      flash[:message] = "Mentor profile successfully created." if @user.mentor_description
      redirect '/mentors'
    else
      flash[:errors] =  @user.errors.full_messages.to_sentence
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
      flash[:message] = "You can only edit a profile that you have created."
      redirect '/mentors'
    end
  end


  patch '/mentors/:id' do
    @user = current_user
    if !params[:mentor_description].empty?
      @user.update(name: params[:name],mentor_description: params[:mentor_description],
        location: params[:location], linked_in: params[:linked_in])
      @user.save!(validate: false)
      flash[:message] = "Profile updated successfully."
      redirect "/mentors/#{@user.id}"
    else
      flash[:errors] = "Something went wrong: #{@user.errors.full_messages.to_sentence}"
      redirect "/mentors/#{@user.id}/edit"
    end
  end


  delete '/mentors/:id' do
    if authorized_to_edit?(params[:id])
    @user = current_user
    @user.destroy
    session.clear
    flash[:message] = "Successfully deleted that entry."
    redirect '/'
  else
    flash[:errors] = "Something went wrong: #{@user.errors.full_messages.to_sentence}"
    redirect "/mentors/#{@user.id}"
    end
  end


end
