class NvsSubsystemsController < ApplicationController

  before_filter :find_project
  before_filter :authorize

  # GET /nvs_subsystems
  # GET /nvs_subsystems.json
  def index
    @nvs_subsystems = NvsSubsystem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_subsystems }
    end
  end

  # GET /nvs_subsystems/1
  # GET /nvs_subsystems/1.json
  def show
    @nvs_subsystem = NvsSubsystem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_subsystem }
    end
  end

  # GET /nvs_subsystems/new
  # GET /nvs_subsystems/new.json
  def new
    @nvs_subsystem = NvsSubsystem.new
    prepare_combos

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_subsystem }
    end
  end

  # GET /nvs_subsystems/1/edit
  def edit
    @nvs_subsystem = NvsSubsystem.find(params[:id])
    prepare_combos
  end

  # POST /nvs_subsystems
  # POST /nvs_subsystems.json
  def create
    @nvs_subsystem = NvsSubsystem.new(params[:nvs_subsystem])
    @nvs_subsystem.project_id = session[:project_id]

    binding.pry
    params['depts_project_ids'].each do |dp|
        #binding.pry
        clone_dp = NvsDeptProject.find(dp).dup #get dept_project selected.
        clone_dp.nvs_subsystem = @nvs_subsystem
        clone_dp.nvs_dept_id = 0
        clone_dp.project_id = session[:project_id]
        clone_dp.save
    end

    respond_to do |format|
      if @nvs_subsystem.save
        format.html { redirect_to @nvs_subsystem, notice: 'Nvs subsystem was successfully created.' }
        format.json { render json: @nvs_subsystem, status: :created, location: @nvs_subsystem }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_subsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_subsystems/1
  # PUT /nvs_subsystems/1.json
  def update
    @nvs_subsystem = NvsSubsystem.find(params[:id])
    
    respond_to do |format|
      if @nvs_subsystem.update_attributes(params[:nvs_subsystem])
        format.html { redirect_to @nvs_subsystem, notice: 'Nvs subsystem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_subsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_subsystems/1
  # DELETE /nvs_subsystems/1.json
  def destroy
    @nvs_subsystem = NvsSubsystem.find(params[:id])
    @nvs_subsystem.destroy

    respond_to do |format|
      format.html { redirect_to nvs_subsystems_url }
      format.json { head :no_content }
    end
  end


  private

  def find_project
    # @project variable must be set before calling the authorize filter
    #binding.pry

    if params[:project_id]
      @project = Project.find(params[:project_id])
      session[:project_id] = @project.id
    else
      @project = Project.find(session[:project_id])
    end

  end

  def prepare_combos
    #depts_projects with nvs_dept_id = 0 represent the list of projects to add, loaded once when NVS plugin is installed.
    @dept_projects = NvsDeptProject.where(:project_id => session[:project_id], :nvs_dept_id => 0).map{|dp| [dp.name, dp.id]}
  end

end
