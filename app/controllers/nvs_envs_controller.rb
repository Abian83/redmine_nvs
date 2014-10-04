class NvsEnvsController < ApplicationController

  before_filter :find_project, :get_types
  before_filter :authorize
  # GET /nvs_envs
  # GET /nvs_envs.json
  def index
    @nvs_envs = NvsEnv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_envs }
    end
  end

  # GET /nvs_envs/1
  # GET /nvs_envs/1.json
  def show
    @nvs_env = NvsEnv.find(params[:id])
    #limit to list LCS    
    if params[:show_all] == 'true'
      @limit = @nvs_env.nvs_envs_lcss.count unless params[:show_all].nil?
    else
      @limit = 5
    end
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_env }
    end
  end

  # GET /nvs_envs/new
  # GET /nvs_envs/new.json
  def new
    @nvs_env = NvsEnv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_env }
    end
  end

  # GET /nvs_envs/1/edit
  def edit
    @nvs_env = NvsEnv.find(params[:id])
  end

  # POST /nvs_envs
  # POST /nvs_envs.json
  def create
    @nvs_env = NvsEnv.new(params[:nvs_env])
    respond_to do |format|
      if @nvs_env.save
        format.html { redirect_to @nvs_env, notice: 'Nvs env was successfully created.' }
        format.json { render json: @nvs_env, status: :created, location: @nvs_env }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_env.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_envs/1
  # PUT /nvs_envs/1.json
  def update
    @nvs_env = NvsEnv.find(params[:id])

    respond_to do |format|
      if @nvs_env.update_attributes(params[:nvs_env])
        format.html { redirect_to @nvs_env, notice: 'Nvs env was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_env.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_envs/1
  # DELETE /nvs_envs/1.json
  def destroy
    @nvs_env = NvsEnv.find(params[:id])
    @nvs_env.destroy

    respond_to do |format|
      format.html { redirect_to nvs_envs_url }
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

  def get_types
    @types = NvsEnv.types
  end


end
