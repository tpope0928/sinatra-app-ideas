class IdeasController < ApplicationController

  get '/ideas' do
    if logged_in?
      @ideas = Idea.all
      erb :'ideas/ideas'
    else
      redirect "/login"
    end
  end

#instead of new show claimed or unclaimed?
  get '/ideas/new' do
    if logged_in?
      erb :'ideas/new'
    else
      redirect "/login"
    end
  end

  post '/ideas' do
    if logged_in? && params[:content] != ""
      @idea = current_user.ideas.build(content: params[:content])
    	@idea.save
      redirect "/ideas/#{@idea.id}"
    elsif logged_in? &&params[:content] == ""
      redirect '/ideas/new'
    else
      redirect '/login'
    end
  end

  get '/ideas/:id/edit' do
    if logged_in?
      @idea = Idea.find(params[:id])
      erb :"/ideas/edit_idea"
    else
      redirect '/login'
    end
  end

  patch '/ideas/:id' do
    @idea = Idea.find(params[:id])
    if logged_in? && params[:content] != ""
      @idea.update(content: params[:content])
      redirect "/ideas/#{@idea.id}"
    else logged_in? && params[:content] != ""
      redirect "/ideas/#{@idea.id}/edit"
    end
  end

  delete '/ideas/:id' do
		if logged_in?
  		@idea = idea.find(params[:id])
  		if @idea.user == current_user
  			@idea.delete
  		else
  			redirect '/ideas'
  		end
  	else
  		redirect '/login'
  	end
  end



end
