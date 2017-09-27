class BraintreeController < ApplicationController
  def new
     @listing = Listing.find(params[:listing_id])
     @start = params[:start_of_reservation_date]
     @end = params[:end_of_reservation_date]
  	 @client_token = Braintree::ClientToken.generate
  end

  def checkout
  	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  	result = Braintree::Transaction.sale(
  		:amount => "10.00",
  		:payment_method_nonce => nonce_from_the_client,
  		:options => {
  			:submit_for_settlement => true
  			}
  		)
  	if result.success?
      @reservation = Reservation.new
      @reservation.user_id = current_user.id
      @reservation.listing_id = params[:listing_id]
      @reservation.start_of_reservation_date = params[:start_date].to_date
      @reservation.end_of_reservation_date = params[:end_date].to_date
      @reservation.save
      customer = @reservation.user.name 
      host = @reservation.listing.user.email
      reservation_id = @reservation.id
      ReservationJob.perform_later(customer, host, reservation_id)
  		redirect_to :root, :flash => { :success => "Transaction successful"}
  	else
      @reservation = Reservation.new
      @reservation.listing_id = params[:listing_id]
      @reservation.start_of_reservation_date = params[:start_date].to_date
      @reservation.end_of_reservation_date = params[:end_date].to_date
      @listing = Listing.find(params[:listing_id])
      flash.now[:danger] = "Transaction failed. Please try again"
  		render template:"reservations/new"
  	end
  end
end
