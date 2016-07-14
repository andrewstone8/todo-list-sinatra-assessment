class TasksController < ApplicationController

  # tasks homepage
  get "/tasks" do
    redirect_if_not_logged_in 
    @tasks = Task.all
    erb :'tasks/index'
  end

  # create new task
  get "/tasks/new" do
    redirect_if_not_logged_in 
    @error_message = params[:error]
    erb :'tasks/new'
  end

  # edit task
  get "/tasks/:id/edit" do
    redirect_if_not_logged_in 
    @error_message = params[:error]
    @task = Task.find(params[:id])
    erb :'tasks/edit'
  end

  post "/tasks/:id" do
    redirect_if_not_logged_in 
    @task = Task.find(params[:id])
    unless Task.valid_params?(params)
      redirect "/tasks/#{@task.id}/edit?error=invalid task"
    end
    @task.update(params.select{|t|t=="content"})
    redirect "/tasks/#{@task.id}"
  end

  # show task
  get "/tasks/:id" do
    redirect_if_not_logged_in 
    @task = Task.find(params[:id])
    erb :'tasks/show'
  end

  post "/tasks" do
    redirect_if_not_logged_in 
    unless Task.valid_params?(params)
      redirect "/tasks/new?error=invalid task"
    end
    Task.create(params)
    redirect "/tasks"
  end

end