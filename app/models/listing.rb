class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy

	self.per_page = 10

	mount_uploaders :images, ImageUploader


	def self.search(search)
		if search.present?
			@listing = Listing.where(["name ILIKE ? or description ILIKE ? or location ILIKE ? or price = ?", "%#{search}%", "%#{search}%", "%#{search}%", "#{search.to_i}"])
		else
			@listing = Listing.all
		end
	end
end
