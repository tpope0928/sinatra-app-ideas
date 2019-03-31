class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/show'
  end

  get '/signup' do
    if logged_in?
			redirect '/tweets'
		else
			erb :'users/create_user'
		end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
			@user = User.create(params)
			session[:user_id] = @user.id
			redirect '/ideas'
		else
			redirect '/signup'
		end
  end

  get '/login' do
    if logged_in?
			redirect '/ideas'
		else
			erb :'users/login'
		end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/ideas'
		else
			redirect '/signup'
		end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
end
