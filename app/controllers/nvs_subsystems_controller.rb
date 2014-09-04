class NvsSubsystemsController < ApplicationController

  before_filter :find_project, :prepare_combos
  before_filter :authorize
  before_filter :get_related_projects , :except => [:index, :new, :destroy, :create]

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

    respond_to do |format|
      if @nvs_subsystem.save
        unless params['depts_project_ids'].nil?
          params['depts_project_ids'].each do |dp|
              dp = NvsDeptProject.find(dp) #get dept_project selected.
              dp.nvs_subsystem = @nvs_subsystem
              dp.nvs_dept_id = 0 if dp.nvs_dept_id.nil?
              dp.project_id = session[:project_id]
              dp.save
          end
        end

        format.html { redirect_to @nvs_subsystem, notice: 'Nvs subsystem was successfully created.' }
        format.json { render json: @nvs_subsystem, status: :created, location: @nvs_subsystem }
      else
        prepare_combos
        get_related_projects
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

        #Remove relations if any
        #binding.pry
        dp2remove =  @project_related.map{|x| "#{x[1]}"} - params['project_related_ids'].to_a
        dp2remove.each do |dp|
          dp = NvsDeptProject.find(dp)
          dp.nvs_subsystem_id = 0
          dp.save
        end
        #Add new relations if any
        unless params['depts_project_ids'].nil?
          params['depts_project_ids'].each do |dp|
              dp = NvsDeptProject.find(dp) #get dept_project selected.
              dp.nvs_subsystem = @nvs_subsystem
              dp.nvs_dept_id = 0 if dp.nvs_dept_id.nil?
              dp.project_id = session[:project_id]
              dp.save
          end
        end

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

    #Clean the relation if exist!
    dps = NvsDeptProject.where(:nvs_subsystem_id => params[:id]).all
    unless dps.nil?
      dps.each do |dp|
        dp.nvs_subsystem_id = 0
        dp.save
      end
    end

    @nvs_subsystem.destroy

    respond_to do |format|
      format.html { redirect_to nvs_subsystems_url }
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

  def prepare_combos
    #depts_projects with nvs_dept_id = 0 represent the list of projects to add, loaded once when NVS plugin is installed.
    @dept_projects = NvsDeptProject.where(:project_id => session[:project_id], :nvs_subsystem_id => 0).map{|dp| [dp.name, dp.id]}
  end

  def get_related_projects
    @project_related = NvsDeptProject.where(:project_id => session[:project_id], :nvs_subsystem_id => params[:id]).map{|dp| [dp.name, dp.id]}
  end

end
