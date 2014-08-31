class MainController < ApplicationController

before_filter :find_project

  def index
    respond_to do |format|
      format.html
    end
  end


private

  def find_project
    # @project variable must be set before calling the authorize filter
    if params[:project_id]
      @project = Project.find(params[:project_id])
      session[:project_id] = @project.id
    else
      @project = Project.find(session[:project_id])
    end
  end

end
