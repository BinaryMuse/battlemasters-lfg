class ListingsController < ApplicationController
  respond_to :html, :json

  before_filter :limit_creations_by_ip, only: [:create]

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
    if @listing.save
      respond_with @listing do |format|
        format.html { redirect_to listings_path, notice: "You've been added to the list!" }
      end
    else
      respond_with @listing do |format|
        format.html { redirect_to listings_path, alert: "Porblems!" }
      end
    end
  end

private

  def limit_creations_by_ip
    if Listing.active.where(ip_address: request.remote_ip).count >= 10
      redirect_to listings_path, alert: "You cannot create more than 10 entries per hour."
    end
  end
end
