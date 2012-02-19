class ListingsController < ApplicationController
  respond_to :html, :json

  def index
    @listings = Listing.active
    @listing  = Listing.new
    respond_with @listings
  end

  def show
    @listing = Listing.find params[:id]
    respond_with @listing
  end

  def create
    @listing = Listing.new params[:listing]
    @listing[:ip_address] = request.remote_ip
    @listing.save
    respond_with @listing do |format|
      format.html { redirect_to listings_path }
    end
  end
end
