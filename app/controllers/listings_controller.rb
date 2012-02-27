class ListingsController < ApplicationController
  respond_to :html, :json

  before_filter :limit_creations_by_ip, only: [:create]

  def index
    @listings = Listing.active.map { |l| present(l) }
    @listing  = Listing.new
    respond_with @listings
  end

  def show
    @listing = Listing.find params[:id]
    respond_with @listing
  end

  def create
    @listing = Listing.active.find_or_initialize_by_realm_and_character(params[:listing][:realm], params[:listing][:character])
    unless @listing.persisted?
      # Can't change values on a "bump"
      @listing.attributes = params[:listing]
      @listing[:ip_address] = request.remote_ip
    end
    @listing.updated_at = Time.now
    if @listing.save
      respond_with @listing do |format|
        format.html { redirect_to listings_path, notice: "You've been added to the list!" }
        format.json { render json: present(@listing) }
      end
    else
      respond_with @listing do |format|
        format.html { redirect_to listings_path, alert: "Porblems!" }
        format.json { render text: "There was a problem creating your listing.", status: 500 }
      end
    end
  end

private

  def limit_creations_by_ip
    if Listing.active.where(ip_address: request.remote_ip).count >= 10
      respond_to do |format|
        format.html { redirect_to listings_path, alert: "You cannot create more than 10 entries per hour." }
        format.json { render text: "You cannot create more than 10 entries per hour.", status: 500 }
      end
    end
  end
end
