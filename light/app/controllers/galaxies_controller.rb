class GalaxiesController < ApplicationController
  # GET /galaxies
  # GET /galaxies.json
  def index
    @galaxies = Galaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galaxies }
    end
  end

  # GET /galaxies/1
  # GET /galaxies/1.json
  def show
    @galaxy = Galaxy.find(params[:id])
    missing_color_groups = { 'hue' => true, 'saturation' => true, 'value' => true}
    @galaxy.color_groups.each do |cg|
      missing_color_groups[cg.group_type] = false
    end

    missing_color_groups.each do |k,v|
      (@galaxy.color_groups << ColorGroup.new(:displayname => '*empty*', :group_type => k, :id => 0)) if v
    end

    respond_to do |format|
      #format.text { render :text => @galaxy.color_groups.inspect }
      format.html # show.html.erb
      format.json { render json: @galaxy }
    end
  end

  # GET /galaxies/new
  # GET /galaxies/new.json
  def new
    @galaxy = Galaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @galaxy }
    end
  end

  # GET /galaxies/1/edit
  def edit
    @galaxy = Galaxy.find(params[:id])
  end

  # POST /galaxies
  # POST /galaxies.json
  def create
    @galaxy = Galaxy.new(params[:galaxy])

    respond_to do |format|
      if @galaxy.save
        format.html { redirect_to @galaxy, notice: 'Galaxy was successfully created.' }
        format.json { render json: @galaxy, status: :created, location: @galaxy }
      else
        format.html { render action: "new" }
        format.json { render json: @galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/1
  # PUT /galaxies/1.json
  def update
    @galaxy = Galaxy.find(params[:id])

    respond_to do |format|
      if @galaxy.update_attributes(params[:galaxy])
        format.html { redirect_to @galaxy, notice: 'Galaxy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/1
  # DELETE /galaxies/1.json
  def destroy
    @galaxy = Galaxy.find(params[:id])
    @galaxy.destroy

    respond_to do |format|
      format.html { redirect_to galaxies_url }
      format.json { head :ok }
    end
  end


  # show actual state of the galaxy
  def display 
    @galaxy = Galaxy.find(params[:id])
    @galaxy.transaction do
      @galaxy.displays.delete_all
      [:color_group_hue, :color_group_saturation, :color_group_value].each do |g|
        @galaxy.color_groups << ColorGroup.find(params[g].to_i)
      end
    end
    Galaxy.display()
    redirect_to @galaxy, notice: 'Galaxy displayed'
    #render :text => params.inspect
  end

end

