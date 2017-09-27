class ReservationMailer < ApplicationMailer
	def booking_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		mail(to: @host, subject: "Successfully Book Enjoy")
  end
end
