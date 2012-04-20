class ColorGroupsController < ApplicationController
  # GET /color_groups
  # GET /color_groups.json
  def index
    @color_groups = ColorGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @color_groups }
    end
  end

  # GET /color_groups/1
  # GET /color_groups/1.json
  def show
    @color_group = ColorGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @color_group }
    end
  end

  # GET /color_groups/new
  # GET /color_groups/new.json
  def new
    @color_group = ColorGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @color_group }
    end
  end

  # GET /color_groups/1/edit
  def edit
    @color_group = ColorGroup.find(params[:id])
  end

  # POST /color_groups
  # POST /color_groups.json
  def create
    @color_group = ColorGroup.new(params[:color_group])

    respond_to do |format|
      if @color_group.save
        format.html { redirect_to @color_group, notice: 'Color group was successfully created.' }
        format.json { render json: @color_group, status: :created, location: @color_group }
      else
        format.html { render action: "new" }
        format.json { render json: @color_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /color_groups/1
  # PUT /color_groups/1.json
  def update
    @color_group = ColorGroup.find(params[:id])

    respond_to do |format|
      if @color_group.update_attributes(params[:color_group])
        format.html { redirect_to @color_group, notice: 'Color group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @color_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_groups/1
  # DELETE /color_groups/1.json
  def destroy
    @color_group = ColorGroup.find(params[:id])
    @color_group.destroy

    respond_to do |format|
      format.html { redirect_to color_groups_url }
      format.json { head :ok }
    end
  end
end
