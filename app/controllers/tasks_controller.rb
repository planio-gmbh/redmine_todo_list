class TasksController < ApplicationController
  unloadable

  accept_rss_auth :feed, :done
  before_filter :require_login
  before_filter :find_task, only: %w(destroy done)

  def index
    @tasks = User.current.tasks
  end

  def create
    task = User.current.tasks.build(:body => params[:task_body])
    if task.save
      flash[:notice] = "Task saved!"
    else
      flash[:error] = "Task could not be saved"
    end
    redirect_to(:action => :index)
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task removed!"
    redirect_to(:action => :index)
  end

  # destroy via get from rss feed link
  def done
    @task.destroy
    render :text => "Task Removed!", :status => 200
  end

  def feed
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    @tasks = User.current.tasks
    render :layout => false
  end

  private

  def find_task
    @task = User.current.tasks.find(params[:id])
  end

end
