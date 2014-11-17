class NvsDeptsController < ApplicationController

  before_filter :find_project, :prepare_combos
  before_filter :authorize
  before_filter :get_related_projects , :except => [:index, :new, :destroy, :create, :users2dept]

  # GET /nvs_depts
  # GET /nvs_depts.json
  def index
    @nvs_depts = NvsDept.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_depts }
    end
  end

  # GET /nvs_depts/1
  # GET /nvs_depts/1.json
  def show
    @nvs_dept = NvsDept.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_dept }
    end
  end

  # GET /nvs_depts/new
  # GET /nvs_depts/new.json
  def new
    @nvs_dept = NvsDept.new
    prepare_combos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_dept }
    end
  end

  # GET /nvs_depts/1/edit
  def edit
    @nvs_dept = NvsDept.find(params[:id])
    prepare_combos
  end

  # POST /nvs_depts
  # POST /nvs_depts.json
  def create
    @nvs_dept = NvsDept.new(params[:nvs_dept])
    @nvs_dept.project_id = session[:project_id]

    respond_to do |format|
      if @nvs_dept.save

        #Add new relations if any
        unless params['depts_project_ids'].nil?
          params['depts_project_ids'].each do |dp|
              dp = NvsDeptProject.find(dp) #get dept_project selected.
              dp.nvs_dept = @nvs_dept
              dp.nvs_subsystem_id = 0 if dp.nvs_subsystem_id.nil?
              dp.project_id = session[:project_id]
              dp.save
          end
        end

        format.html { redirect_to @nvs_dept, notice: 'Nvs dept was successfully created.' }
        format.json { render json: @nvs_dept, status: :created, location: @nvs_dept }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_dept.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_depts/1
  # PUT /nvs_depts/1.json
  def update
    @nvs_dept = NvsDept.find(params[:id])

    #Remove relations if any
    #binding.pry
    dp2remove =  @project_related.map{|x| "#{x[1]}"} - params['project_related_ids'].to_a
    dp2remove.each do |dp|
      dp = NvsDeptProject.find(dp)
      dp.nvs_dept_id = 0
      dp.save
    end

    #Add new relations if any
    unless params['depts_project_ids'].nil?
      params['depts_project_ids'].each do |dp|
          dp = NvsDeptProject.find(dp) #get dept_project selected.
          dp.nvs_dept = @nvs_dept
          dp.nvs_subsystem_id = 0 if dp.nvs_subsystem_id.nil?
          dp.project_id = session[:project_id]
          dp.save
      end
    end

    respond_to do |format|
      if @nvs_dept.update_attributes(params[:nvs_dept])
        format.html { redirect_to @nvs_dept, notice: 'Nvs dept was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_dept.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_depts/1
  # DELETE /nvs_depts/1.json
  def destroy
    @nvs_dept = NvsDept.find(params[:id])

    #Clean the relation if exist!
    dps = NvsDeptProject.where(:nvs_dept_id => params[:id]).all
    unless dps.nil?
      dps.each do |dp|
        dp.nvs_dept_id = 0
        dp.save
      end
    end

    @nvs_dept.destroy

    respond_to do |format|
      format.html { redirect_to nvs_depts_url }
      format.json { head :no_content }
    end
  end

  def users2dept
    if params["users_selected"]
      dept = NvsDept.find params["Departaments"]
      errors = []
      info = []
      params["users_selected"].each do |u|
        deptUser = NvsDeptUser.where(:user_id => u).first
        deptUser.nvs_dept_id = dept.id
        unless deptUser.save
          errors << deptUser.errors
        else
          info << deptUser.user.name + " "
        end
      end
      if errors.empty?
        flash.now[:notice] = "User added to " + dept.name + " : " + info.to_s
      else
        flash.now[:error] = "something was wrong"
      end
    end

      @depts = NvsDept.all.map{|x| [x.name,x.id]}
      @users = User.all.map{|x| [x.name,x.id]}
      @authLevels = NvsDeptUser.levels.map{|x| [x[0].to_s,x[1].to_s]}
      @tmp_authLevels = NvsDeptUser.temp_levels.map{|x| [x[0].to_s,x[1].to_s]}



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
    @dept_projects = NvsDeptProject.where(:project_id => session[:project_id], :nvs_dept_id => 0).map{|dp| [dp.name, dp.id]}
  end

  def get_related_projects
    @project_related = NvsDeptProject.where(:project_id => session[:project_id], :nvs_dept_id => params[:id]).map{|dp| [dp.name, dp.id]}
  end


end
