class ColorHuesController < ApplicationController
  # GET /color_hues
  # GET /color_hues.json
  def index
    @color_hues = ColorHue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @color_hues }
    end
  end

  # GET /color_hues/1
  # GET /color_hues/1.json
  def show
    @color_hue = ColorHue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @color_hue }
    end
  end

  # GET /color_hues/new
  # GET /color_hues/new.json
  def new
    @color_hue = ColorHue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @color_hue }
    end
  end

  # GET /color_hues/1/edit
  def edit
    @color_hue = ColorHue.find(params[:id])
  end

  # POST /color_hues
  # POST /color_hues.json
  def create
    @color_hue = ColorHue.new(params[:color_hue])

    respond_to do |format|
      if @color_hue.save
        format.html { redirect_to @color_hue, notice: 'Color hue was successfully created.' }
        format.json { render json: @color_hue, status: :created, location: @color_hue }
      else
        format.html { render action: "new" }
        format.json { render json: @color_hue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /color_hues/1
  # PUT /color_hues/1.json
  def update
    @color_hue = ColorHue.find(params[:id])

    respond_to do |format|
      if @color_hue.update_attributes(params[:color_hue])
        format.html { redirect_to @color_hue, notice: 'Color hue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @color_hue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_hues/1
  # DELETE /color_hues/1.json
  def destroy
    @color_hue = ColorHue.find(params[:id])
    @color_hue.destroy

    respond_to do |format|
      format.html { redirect_to color_hues_url }
      format.json { head :ok }
    end
  end
end
