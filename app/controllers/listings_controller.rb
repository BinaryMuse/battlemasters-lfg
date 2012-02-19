class ListingsController < ApplicationController
  def index
    @listings = Listing.active
    @listing  = Listing.new
    logger.info "Request IP is #{request.remote_ip}"
    logger.info "Forwarded IP is #{request.env["HTTP_X_FORWARDED_FOR"]}"
  end

  def create
    @listing = Listing.new params[:listing]
    if @listing.save
      redirect_to listings_path, notice: "You have been added to the list!"
    else
      @listings = Listing.active
      render :index, alert: "There was a porblem!"
    end
  end
end
