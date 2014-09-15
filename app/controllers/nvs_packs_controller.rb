class NvsPacksController < ApplicationController
  # GET /nvs_packs
  # GET /nvs_packs.json
  def index
    @nvs_packs = NvsPack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nvs_packs }
    end
  end

  # GET /nvs_packs/1
  # GET /nvs_packs/1.json
  def show
    @nvs_pack = NvsPack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nvs_pack }
    end
  end

  # GET /nvs_packs/new
  # GET /nvs_packs/new.json
  def new
    @nvs_pack = NvsPack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nvs_pack }
    end
  end

  # GET /nvs_packs/1/edit
  def edit
    @nvs_pack = NvsPack.find(params[:id])
  end

  # POST /nvs_packs
  # POST /nvs_packs.json
  def create
    @nvs_pack = NvsPack.new(params[:nvs_pack])

    respond_to do |format|
      if @nvs_pack.save
        format.html { redirect_to @nvs_pack, notice: 'Nvs pack was successfully created.' }
        format.json { render json: @nvs_pack, status: :created, location: @nvs_pack }
      else
        format.html { render action: "new" }
        format.json { render json: @nvs_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nvs_packs/1
  # PUT /nvs_packs/1.json
  def update
    @nvs_pack = NvsPack.find(params[:id])

    respond_to do |format|
      if @nvs_pack.update_attributes(params[:nvs_pack])
        format.html { redirect_to @nvs_pack, notice: 'Nvs pack was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nvs_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nvs_packs/1
  # DELETE /nvs_packs/1.json
  def destroy
    @nvs_pack = NvsPack.find(params[:id])
    @nvs_pack.destroy

    respond_to do |format|
      format.html { redirect_to nvs_packs_url }
      format.json { head :no_content }
    end
  end
end
