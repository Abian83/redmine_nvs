class NvsGoalsController < ApplicationController

  before_filter :find_project
  before_filter :authorize
  before_filter :find_user_and_goaltypes , :expect => [:index,:show, :detroy]

  # GET /nvs_goals
  # GET /nvs_goals.json
  def index
    @nvs_goals = NvsGoal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_goals }
    end
  end

  # GET /nvs_goals/1
  # GET /nvs_goals/1.json
  def show
    @nvs_goal = NvsGoal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_goal }
    end
  end

  # GET /nvs_goals/new
  # GET /nvs_goals/new.json
  def new
    @nvs_goal = NvsGoal.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_goal }
    end
  end

  # GET /nvs_goals/1/edit
  def edit
    @nvs_goal = NvsGoal.find(params[:id])
  end

  # POST /nvs_goals
  # POST /nvs_goals.json
  def create
    @nvs_goal = NvsGoal.new(params[:nvs_goal])
    @nvs_goal.project_id = @project

    respond_to do |format|
      if @nvs_goal.save
        format.html { redirect_to @nvs_goal, notice: 'Nvs goal was successfully created.' }
        format.json { render json: @nvs_goal, status: :created, location: @nvs_goal }
      else
        @nvs_goal_types = NvsGoalType.all.map{|x| [x.name, x.id]}
        format.html { render action: "new" }
        format.json { render json: @nvs_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_goals/1
  # PUT /nvs_goals/1.json
  def update
    @nvs_goal = NvsGoal.find(params[:id])
    respond_to do |format|
      if @nvs_goal.update_attributes(params[:nvs_goal])
        format.html { redirect_to @nvs_goal, notice: 'Nvs goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_goals/1
  # DELETE /nvs_goals/1.json
  def destroy
    @nvs_goal = NvsGoal.find(params[:id])
    @nvs_goal.destroy

    respond_to do |format|
      format.html { redirect_to nvs_goals_url }
      format.json { head :no_content }
    end
  end

  private

    def find_project
      if params[:project_id]
        @project = Project.find(params[:project_id])
        session[:project_id] = @project.id
      else
        @project = Project.find(session[:project_id])
      end
    end

    def find_user_and_goaltypes
      @nvs_goal_types = NvsGoalType.all.map{|x| [x.name, x.id]}
      @users = User.all.map{|x| [x.name, x.id]}
    end

end
