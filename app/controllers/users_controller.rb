class UsersController < ApplicationController

  get '/users/:id' do
    if !logged_in?
      redirect '/lists'
    end

    @user = User.find(params[:id])
    if @user == current_user && !@user.nil?
      erb :'users/show'
    else
      redirect '/lists'
    end
  end

  # user sign up
  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/tasks'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/lists'
    end
  end

  #user sign in
  get '/login' do
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/lists'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/lists"
    else
      redirect '/signup'
    end
  end
end