class NvsGoalTypesController < ApplicationController

  before_filter :find_project
  before_filter :authorize
  before_filter :find_user , :expect => [:index,:show, :detroy]

  # GET /nvs_goal_types
  # GET /nvs_goal_types.json
  def index
    @nvs_goal_types = NvsGoalType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_goal_types }
    end
  end

  # GET /nvs_goal_types/1
  # GET /nvs_goal_types/1.json
  def show
    @nvs_goal_type = NvsGoalType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_goal_type }
    end
  end

  # GET /nvs_goal_types/new
  # GET /nvs_goal_types/new.json
  def new
    @nvs_goal_type = NvsGoalType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_goal_type }
    end
  end

  # GET /nvs_goal_types/1/edit
  def edit
    @nvs_goal_type = NvsGoalType.find(params[:id])
  end

  # POST /nvs_goal_types
  # POST /nvs_goal_types.json
  def create
    @nvs_goal_type = NvsGoalType.new(params[:nvs_goal_type])
    @nvs_goal_type.created_by = User.current
    respond_to do |format|
      if @nvs_goal_type.save
        format.html { redirect_to @nvs_goal_type, notice: 'Nvs goal type was successfully created.' }
        format.json { render json: @nvs_goal_type, status: :created, location: @nvs_goal_type }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_goal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_goal_types/1
  # PUT /nvs_goal_types/1.json
  def update
    @nvs_goal_type = NvsGoalType.find(params[:id])

    respond_to do |format|
      if @nvs_goal_type.update_attributes(params[:nvs_goal_type])
        format.html { redirect_to @nvs_goal_type, notice: 'Nvs goal type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_goal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_goal_types/1
  # DELETE /nvs_goal_types/1.json
  def destroy
    @nvs_goal_type = NvsGoalType.find(params[:id])
    @nvs_goal_type.destroy

    respond_to do |format|
      format.html { redirect_to nvs_goal_types_url }
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

  def find_user
    @users = User.all.map{|x| [x.name, x.id]}
  end


end
