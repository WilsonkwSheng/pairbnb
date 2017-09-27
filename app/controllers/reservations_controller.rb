class ReservationsController < ApplicationController
	def index
		@reservation = Reservation.all
	end

	def new
		@reservation = Reservation.new
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		if @reservation.check_overlapping_dates
			redirect_to braintree_new_path(listing_id: @reservation.listing_id, start_of_reservation_date: @reservation.start_of_reservation_date, end_of_reservation_date: @reservation.end_of_reservation_date)
		end
		# if @reservation.save
		# 	redirect_to all_listings_path
		# 	flash[:success] = "Successfully made reservation!"
		# else
		# 	@errors = @reservation.errors.full_messages
		# 	@listing = Listing.find(@reservation.listing_id)
		# 	render "new"
		# end
	end

	def show
		@reservation = Reservation.find(params[:id])
		# @reservation = Reservation.where(user_id: current_user.id)
	end

	private

	def reservation_params
		params.require(:reservation).permit(:start_of_reservation_date, :end_of_reservation_date, :user_id, :listing_id)
	end
end
