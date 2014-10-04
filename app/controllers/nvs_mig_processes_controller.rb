class NvsMigProcessesController < ApplicationController

  before_filter :find_project
  before_filter :authorize

  # GET /nvs_mig_processes
  # GET /nvs_mig_processes.json
  def index
    @nvs_mig_processes = NvsMigProcess.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_mig_processes }
    end
  end

  # GET /nvs_mig_processes/1
  # GET /nvs_mig_processes/1.json
  def show
    @nvs_mig_process = NvsMigProcess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_mig_process }
    end
  end

  # GET /nvs_mig_processes/new
  # GET /nvs_mig_processes/new.json
  def new
    @nvs_mig_process = NvsMigProcess.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_mig_process }
    end
  end

  # GET /nvs_mig_processes/1/edit
  def edit
    @nvs_mig_process = NvsMigProcess.find(params[:id])
  end

  # POST /nvs_mig_processes
  # POST /nvs_mig_processes.json
  def create
    @nvs_mig_process = NvsMigProcess.new(params[:nvs_mig_process])

    respond_to do |format|
      if @nvs_mig_process.save
        format.html { redirect_to @nvs_mig_process, notice: 'Nvs mig process was successfully created.' }
        format.json { render json: @nvs_mig_process, status: :created, location: @nvs_mig_process }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_mig_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_mig_processes/1
  # PUT /nvs_mig_processes/1.json
  def update
    @nvs_mig_process = NvsMigProcess.find(params[:id])

    respond_to do |format|
      if @nvs_mig_process.update_attributes(params[:nvs_mig_process])
        format.html { redirect_to @nvs_mig_process, notice: 'Nvs mig process was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_mig_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_mig_processes/1
  # DELETE /nvs_mig_processes/1.json
  def destroy
    @nvs_mig_process = NvsMigProcess.find(params[:id])
    @nvs_mig_process.destroy

    respond_to do |format|
      format.html { redirect_to nvs_mig_processes_url }
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

end
