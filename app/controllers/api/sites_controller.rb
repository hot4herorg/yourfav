class Api::SitesController < ApplicationController
  before_action :set_api_site, only: [:show, :edit, :update, :destroy]

  # GET /api/sites
  # GET /api/sites.json
  def index
    @api_sites = Api::Site.all
  end

  # GET /api/sites/1
  # GET /api/sites/1.json
  def show
  end

  # GET /api/sites/new
  def new
    @api_site = Api::Site.new
  end

  # GET /api/sites/1/edit
  def edit
  end

  # POST /api/sites
  # POST /api/sites.json
  def create
    @api_site = Api::Site.new(api_site_params)

    respond_to do |format|
      if @api_site.save
        format.html { redirect_to @api_site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @api_site }
      else
        format.html { render :new }
        format.json { render json: @api_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/sites/1
  # PATCH/PUT /api/sites/1.json
  def update
    respond_to do |format|
      if @api_site.update(api_site_params)
        format.html { redirect_to @api_site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_site }
      else
        format.html { render :edit }
        format.json { render json: @api_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/sites/1
  # DELETE /api/sites/1.json
  def destroy
    @api_site.destroy
    respond_to do |format|
      format.html { redirect_to api_sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_site
      @api_site = Api::Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_site_params
      params[:api_site]
    end
end
