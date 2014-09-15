class NvsDeptUsersController < ApplicationController

  before_filter :find_project, :prepare_combos
  before_filter :authorize

  # GET /nvs_dept_users
  # GET /nvs_dept_users.json
  def index
    @nvs_dept_users = NvsDeptUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_dept_users }
    end
  end

  # GET /nvs_dept_users/1
  # GET /nvs_dept_users/1.json
  def show
    @nvs_dept_user = NvsDeptUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_dept_user }
    end
  end

  # GET /nvs_dept_users/new
  # GET /nvs_dept_users/new.json
  def new
    @nvs_dept_user = NvsDeptUser.new
    prepare_combos

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_dept_user }
    end
  end

  # GET /nvs_dept_users/1/edit
  def edit
    @nvs_dept_user = NvsDeptUser.find(params[:id])
  end

  # POST /nvs_dept_users
  # POST /nvs_dept_users.json
  def create
    @nvs_dept_user = NvsDeptUser.new(params[:nvs_dept_user])
      respond_to do |format|
        if @nvs_dept_user.save
          format.html { redirect_to @nvs_dept_user, notice: 'Nvs dept user was successfully created.' }
          format.json { render json: @nvs_dept_user, status: :created, location: @nvs_dept_user }
        else
          format.html { render action: "new" }
          format.json { render json: @nvs_dept_user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PUT /nvs_dept_users/1
  # PUT /nvs_dept_users/1.json
  def update
    @nvs_dept_user = NvsDeptUser.find(params[:id])

    respond_to do |format|
      if @nvs_dept_user.update_attributes(params[:nvs_dept_user])
        format.html { redirect_to @nvs_dept_user, notice: 'Nvs dept user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_dept_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_dept_users/1
  # DELETE /nvs_dept_users/1.json
  def destroy
    @nvs_dept_user = NvsDeptUser.find(params[:id])
    @nvs_dept_user.destroy

    respond_to do |format|
      format.html { redirect_to nvs_dept_users_url }
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
    #Users already related to a departaments
    assigned_users = NvsDeptUser.all.map{|x| x.user_id}
    all_users      = User.all.map{|x| x.id}

    @users = User.where('id in (?)',all_users - assigned_users ).map{|x| [x.name,x.id]}

    @authLevels = NvsDeptUser.levels.map{|x| [x[0].to_s,x[1].to_s]}
    @tmp_authLevels = NvsDeptUser.temp_levels.map{|x| [x[0].to_s,x[1].to_s]}

    @nvs_dept_ids = NvsDept.all.map{|x| [x.name,x.id]}
  end

end
