class VisitsController < ApplicationController

  # Sets the CORS headers
  def set_cors_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
    headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
    headers["Access-Control-Max-Age"] = "3600"
  end

  # Sends a restricted resource
  def resource
    set_cors_headers
    render :text => "OK here is your restricted resource!"
  end

  # GET /visits
  # GET /visits.json
  def index
    @site = Site.find(params[:site_id])
    @visits = @site.visits

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visits }
    end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
    @site = Site.find(params[:site_id])
    @visit = Visit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visit }
    end
  end

  # GET /visits/new
  # GET /visits/new.json
  def new
    @site = Site.find(params[:site_id])
    @visit = Visit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visit }
    end
  end

  # GET /visits/1/edit
  def edit
    @site = Site.find(params[:site_id])
    @visit = Visit.find(params[:id])
  end

  # POST /visits
  # POST /visits.json
  # Creates a visit by looking at url and duration parameters
  # requires: base_url must match site.base_url for visit to register
  # otherwise the visit is not created
  def create
    set_cors_headers
    @site = Site.find(params[:site_id])
    if params[:base_url] == @site.base_url
      @visit = @site.visits.create(:url => params[:url], :duration => params[:duration])
    end

    respond_to do |format|
      if @visit.save
        format.html { redirect_to site_visit_path(@site, @visit), notice: 'Visit was successfully created.' }
        format.json { render json: @visit, status: :created, location: @visit }
      else
        format.html { render action: "new" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /visits/1
  # PUT /visits/1.json
  def update
    @site = Site.find(params[:site_id])
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        format.html { redirect_to site_visit_path(@site, @visit), notice: 'Visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @site = Site.find(params[:site_id])
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to site_visits_path }
      format.json { head :no_content }
    end
  end
end
