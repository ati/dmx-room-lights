class ColorSaturationsController < ApplicationController
  # GET /color_saturations
  # GET /color_saturations.json
  def index
    @color_saturations = ColorSaturation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @color_saturations }
    end
  end

  # GET /color_saturations/1
  # GET /color_saturations/1.json
  def show
    @color_saturation = ColorSaturation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @color_saturation }
    end
  end

  # GET /color_saturations/new
  # GET /color_saturations/new.json
  def new
    @color_saturation = ColorSaturation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @color_saturation }
    end
  end

  # GET /color_saturations/1/edit
  def edit
    @color_saturation = ColorSaturation.find(params[:id])
  end

  # POST /color_saturations
  # POST /color_saturations.json
  def create
    @color_saturation = ColorSaturation.new(params[:color_saturation])

    respond_to do |format|
      if @color_saturation.save
        format.html { redirect_to @color_saturation, notice: 'Color saturation was successfully created.' }
        format.json { render json: @color_saturation, status: :created, location: @color_saturation }
      else
        format.html { render action: "new" }
        format.json { render json: @color_saturation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /color_saturations/1
  # PUT /color_saturations/1.json
  def update
    @color_saturation = ColorSaturation.find(params[:id])

    respond_to do |format|
      if @color_saturation.update_attributes(params[:color_saturation])
        format.html { redirect_to @color_saturation, notice: 'Color saturation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @color_saturation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_saturations/1
  # DELETE /color_saturations/1.json
  def destroy
    @color_saturation = ColorSaturation.find(params[:id])
    @color_saturation.destroy

    respond_to do |format|
      format.html { redirect_to color_saturations_url }
      format.json { head :ok }
    end
  end
end
