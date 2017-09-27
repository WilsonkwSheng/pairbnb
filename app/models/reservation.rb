class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validate :check_overlapping_dates

	def check_overlapping_dates
		listing.reservations.each do |old_booking|
			if overlap?(self, old_booking)
				return errors.add(:overlapping_dates, "The booking dates conflict with existing reservation")
			end
		end
	end

	def overlap?(x,y)
		(x.start_of_reservation_date - y.end_of_reservation_date) * (y.start_of_reservation_date - x.end_of_reservation_date) > 0
	end
end
