class ListsController < ApplicationController
  
  # list homepage
  get "/lists" do
    redirect_if_not_logged_in
    @lists = List.all
    erb :'lists/index'
  end

  # new lists
  get "/lists/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'lists/new'
  end

  # edit lists
  get "/lists/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @list = List.find(params[:id])
    erb :'lists/edit'
  end

  post "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    unless List.valid_params?(params)
      redirect "/lists/#{@list.id}/edit?error=invalid list"
    end
    @list.update(params.select{|list|list=="name"})
    redirect "/lists/#{@list.id}"
  end


  # show single list
  get "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    erb :'lists/show'
  end

  post "/lists" do
    redirect_if_not_logged_in

    unless List.valid_params?(params)
      redirect "/lists/new?error=invalid list"
    end
    List.create(params)
    redirect "/lists"
  end

end