class NvsDeptProjectsController < ApplicationController

  before_filter :find_project
  before_filter :authorize
  before_filter :get_subsystems_and_depts , :only => [:new,:edit,:update]

  # GET /nvs_dept_projects
  # GET /nvs_dept_projects.json
  def index
    @nvs_dept_projects = NvsDeptProject.order('name ASC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_dept_projects }
    end
  end

  # GET /nvs_dept_projects/1
  # GET /nvs_dept_projects/1.json
  def show
    @nvs_dept_project = NvsDeptProject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_dept_project }
    end
  end

  # GET /nvs_dept_projects/new
  # GET /nvs_dept_projects/new.json
  def new
    @nvs_dept_project = NvsDeptProject.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_dept_project }
    end
  end

  # GET /nvs_dept_projects/1/edit
  def edit
    @nvs_dept_project  = NvsDeptProject.find(params[:id])
  end

  # POST /nvs_dept_projects
  # POST /nvs_dept_projects.json
  def create
    #binding.pry
    @nvs_dept_project = NvsDeptProject.new(params[:nvs_dept_project])
    @nvs_dept_project.nvs_subsystem_id = 0
    @nvs_dept_project.nvs_dept_id = 0
    @nvs_dept_project.project_id = session[:project_id]

    respond_to do |format|
      if @nvs_dept_project.save
        format.html { redirect_to @nvs_dept_project, notice: 'Nvs dept project was successfully created.' }
        format.json { render json: @nvs_dept_project, status: :created, location: @nvs_dept_project }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_dept_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_dept_projects/1
  # PUT /nvs_dept_projects/1.json
  def update
    @nvs_dept_project = NvsDeptProject.find(params[:id])

    respond_to do |format|
      if @nvs_dept_project.update_attributes(params[:nvs_dept_project])
        format.html { redirect_to @nvs_dept_project, notice: 'Nvs dept project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_dept_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_dept_projects/1
  # DELETE /nvs_dept_projects/1.json
  def destroy
    @nvs_dept_project = NvsDeptProject.find(params[:id])
    @nvs_dept_project.destroy

    respond_to do |format|
      format.html { redirect_to nvs_dept_projects_url }
      format.json { head :no_content }
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


  def get_subsystems_and_depts
    #sub_ids  = NvsDeptProject.all.group_by{|x| x.nvs_subsystem_id}.map{|x| x[0]}
    #dept_ids = NvsDeptProject.all.group_by{|x| x.nvs_dept_id}.map{|x| x[0]}

    #Only add subsystem or departments without relation.
    #@nvs_subsystem_ids = NvsSubsystem.where('id not in (?)' , sub_ids).map{|x| x.id}.append(["",0])
    #@nvs_dept_ids      = NvsDept.where('id not in (?)' , dept_ids).map{|x| x.id}.append(["",0])

    @nvs_subsystem_ids = NvsSubsystem.all.map{|x| [x.name,x.id]}.append(["",0])
    @nvs_dept_ids      = NvsDept.all.map{|x| [x.name,x.id]}.append(["",0])
  end


end
