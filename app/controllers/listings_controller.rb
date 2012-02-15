class ListingsController < ApplicationController
  def index
    @listings = Listing.active
    @listing  = Listing.new
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
