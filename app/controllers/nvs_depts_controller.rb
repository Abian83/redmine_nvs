class NvsDeptsController < ApplicationController

  before_filter :find_project
  before_filter :authorize

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
    prepare_combos
    @nvs_dept = NvsDept.find(params[:id])
  end

  # POST /nvs_depts
  # POST /nvs_depts.json
  def create
    @nvs_dept = NvsDept.new(params[:nvs_dept])
    @nvs_dept.project_id = session[:project_id]


    params['depts_project_ids'].each do |dp|
        #binding.pry
        clone_dp = NvsDeptProject.find(dp).dup #get dept_project selected.
        clone_dp.nvs_dept = @nvs_dept
        clone_dp.project_id = session[:project_id]
        clone_dp.save
    end



    respond_to do |format|
      if @nvs_dept.save
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
    @nvs_dept.destroy

    respond_to do |format|
      format.html { redirect_to nvs_depts_url }
      format.json { head :no_content }
    end
  end

  def users2dept
    binding.pry
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


end
