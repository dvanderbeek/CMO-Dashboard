class HomeController < ApplicationController
  def index
    if current_user
      @sites = current_user.sites.all
    end
  end
end
