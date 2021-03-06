class SitesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  layout :resolve_layout

  def members
    @sites = current_user.sites.all
    if params[:site_id]
      @members = Site.find(params[:site_id]).members.all
    else
      @members = current_user.members.all
    end

  end

  def index
    @sites = current_user.sites.all
    @posts = current_user.posts.search(params[:search].to_s.upcase).filter_site(params[:site]).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
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
    @sites = current_user.sites

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @sites = current_user.sites
    @site = current_user.sites.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.build(params[:site])

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
    @site = current_user.sites.find(params[:id])

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
    @site = current_user.sites.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private

  def resolve_layout
    case action_name
    when "show"
      "site"
    else
      "design"
    end
  end
end
