class SitesController < ApplicationController
  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/visits
  # Add 1 to found site's visits, or create a site 
  # with given id and 1 visit if no site is found.
  def visits
    @site = Site.find_by_id(params[:id])
	if @site
		@site.visits = @site.visits + 1
		@site.save
	else
		@site = Site.new
		@site.id = params[:id]
		@site.visits = 1
		@site.save
	end
  end
  
  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(params[:site])
	# make visits start at 0
	@site.visits = 0
	
    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end
end
