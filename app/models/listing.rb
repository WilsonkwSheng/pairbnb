class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
	self.per_page = 10
	mount_uploaders :images, ImageUploader


	#Listing.start_name("sdfsdfs")

	scope :start_name, -> (input_name) { where name: input_name}
	scope :location, -> (location) {where location: location}
	scope :price, -> (price) {where price: price}

	########### Refactor Search Using Scope #####################
	# search bar for listing display
		# def self.search(search)
		# 	if search.present?
		# 		@listing = Listing.where(["name ILIKE ? or description ILIKE ? or location ILIKE ? or price = ?", "%#{search}%", "%#{search}%", "%#{search}%", "#{search.to_i}"])
		# 	else
		# 		@listing = Listing.all
		# 	end
		# end
	#############################################################

	def self.find_all_listing(user)
		if user.superadmin?
			Listing.all#.page(params[:page]).order('created_at DESC')
		elsif user.moderator?
			Listing.where(:verification => false)#.page(params[:page]).order('created_at DESC')
		else
			Listing.where(:verification => true)#.page(params[:page]).order('created_at DESC')
		end
	end
end
