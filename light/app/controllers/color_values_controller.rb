class ColorValuesController < ApplicationController
  # GET /color_values
  # GET /color_values.json
  def index
    @color_values = ColorValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @color_values }
    end
  end

  # GET /color_values/1
  # GET /color_values/1.json
  def show
    @color_value = ColorValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @color_value }
    end
  end

  # GET /color_values/new
  # GET /color_values/new.json
  def new
    @color_value = ColorValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @color_value }
    end
  end

  # GET /color_values/1/edit
  def edit
    @color_value = ColorValue.find(params[:id])
  end

  # POST /color_values
  # POST /color_values.json
  def create
    @color_value = ColorValue.new(params[:color_value])

    respond_to do |format|
      if @color_value.save
        format.html { redirect_to @color_value, notice: 'Color value was successfully created.' }
        format.json { render json: @color_value, status: :created, location: @color_value }
      else
        format.html { render action: "new" }
        format.json { render json: @color_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /color_values/1
  # PUT /color_values/1.json
  def update
    @color_value = ColorValue.find(params[:id])

    respond_to do |format|
      if @color_value.update_attributes(params[:color_value])
        format.html { redirect_to @color_value, notice: 'Color value was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @color_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_values/1
  # DELETE /color_values/1.json
  def destroy
    @color_value = ColorValue.find(params[:id])
    @color_value.destroy

    respond_to do |format|
      format.html { redirect_to color_values_url }
      format.json { head :ok }
    end
  end
end
