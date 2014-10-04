class NvsMigStatusesController < ApplicationController

  before_filter :find_project
  before_filter :authorize

  # GET /nvs_mig_statuses
  # GET /nvs_mig_statuses.json
  def index
    @nvs_mig_statuses = NvsMigStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_mig_statuses }
    end
  end

  # GET /nvs_mig_statuses/1
  # GET /nvs_mig_statuses/1.json
  def show
    @nvs_mig_status = NvsMigStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_mig_status }
    end
  end

  # GET /nvs_mig_statuses/new
  # GET /nvs_mig_statuses/new.json
  def new
    @nvs_mig_status = NvsMigStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_mig_status }
    end
  end

  # GET /nvs_mig_statuses/1/edit
  def edit
    @nvs_mig_status = NvsMigStatus.find(params[:id])
  end

  # POST /nvs_mig_statuses
  # POST /nvs_mig_statuses.json
  def create
    @nvs_mig_status = NvsMigStatus.new(params[:nvs_mig_status])
    @nvs_mig_status.project_id = @project.id

    respond_to do |format|
      if @nvs_mig_status.save
        format.html { redirect_to @nvs_mig_status, notice: 'Nvs mig status was successfully created.' }
        format.json { render json: @nvs_mig_status, status: :created, location: @nvs_mig_status }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_mig_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_mig_statuses/1
  # PUT /nvs_mig_statuses/1.json
  def update
    @nvs_mig_status = NvsMigStatus.find(params[:id])

    respond_to do |format|
      if @nvs_mig_status.update_attributes(params[:nvs_mig_status])
        format.html { redirect_to @nvs_mig_status, notice: 'Nvs mig status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_mig_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_mig_statuses/1
  # DELETE /nvs_mig_statuses/1.json
  def destroy
    @nvs_mig_status = NvsMigStatus.find(params[:id])
    @nvs_mig_status.destroy

    respond_to do |format|
      format.html { redirect_to nvs_mig_statuses_url }
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
