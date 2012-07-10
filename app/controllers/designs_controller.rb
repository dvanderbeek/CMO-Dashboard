class DesignsController < ApplicationController
  layout "design"
  def index
    @sites = current_user.sites
    @posts = current_user.posts.search(params[:search].to_s.upcase).filter_site(params[:site]).order('created_at DESC')
  end

end
