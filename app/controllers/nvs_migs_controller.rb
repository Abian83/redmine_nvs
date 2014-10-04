class NvsMigsController < ApplicationController
  
  before_filter :find_project
  before_filter :authorize
  before_filter :prepare_combos

  # GET /nvs_migs
  # GET /nvs_migs.json
  def index
    @nvs_migs = NvsMig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_migs }
    end
  end

  # GET /nvs_migs/1
  # GET /nvs_migs/1.json
  def show
    @nvs_mig = NvsMig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_mig }
    end
  end

  # GET /nvs_migs/new
  # GET /nvs_migs/new.json
  def new
    @nvs_mig = NvsMig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_mig }
    end
  end

  # GET /nvs_migs/1/edit
  def edit
    @nvs_mig = NvsMig.find(params[:id])
  end

  # POST /nvs_migs
  # POST /nvs_migs.json
  def create
    @nvs_mig = NvsMig.new(params[:nvs_mig])
    @nvs_mig.project_id = @project.id
    respond_to do |format|
      if @nvs_mig.save
        format.html { redirect_to @nvs_mig, notice: 'Nvs mig was successfully created.' }
        format.json { render json: @nvs_mig, status: :created, location: @nvs_mig }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_mig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_migs/1
  # PUT /nvs_migs/1.json
  def update
    @nvs_mig = NvsMig.find(params[:id])

    respond_to do |format|
      if @nvs_mig.update_attributes(params[:nvs_mig])
        format.html { redirect_to @nvs_mig, notice: 'Nvs mig was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_mig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_migs/1
  # DELETE /nvs_migs/1.json
  def destroy
    @nvs_mig = NvsMig.find(params[:id])
    @nvs_mig.destroy

    respond_to do |format|
      format.html { redirect_to nvs_migs_url }
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
    @nvs_envs = NvsEnv.all.map{|x| [x.name, x.id]}
    @nvs_mig_statuses = NvsMigStatus.all.map{|x| [x.name, x.id]}
  end

  
end
