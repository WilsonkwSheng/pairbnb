class ListingsController < ApplicationController	
	def new
		@listing = Listing.new
	end

	def index
		@listings = Listing.where(user_id: params[:user_id])
	end

	def create
		@listing = Listing.new(listing_params) # Listing.new(params[:user]) == User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password]
		if @listing.save
			redirect_to user_listing_path(current_user, @listing)
			# same as redirect_to "/users/#{current_user.id}/listings/#{@listing.id}"
			flash[:success] = "Successfully create a listing!"
		else
			render "index"
			flash[:notice] = "Didnt work"
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if listing_params
			@listing.update(listing_params)
			redirect_to sign_in_path
			flash[:success] = "Successfully updated the list"
		else
			@listing.update(verification: true)
			redirect_to sign_in_path
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to sign_in_path
		flash[:success] = "Successfully deleted the list"
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def all	
		# @listing = Listing.starts_with(params[:name]).page(params[:page]).order('created_at DESC') if params[:name].present?
		# @listing = Listing.location(params[:location]).page(params[:page]).order('created_at DESC') if params[:location].present?
		# @listing = Listing.price(params[:price]).page(params[:page]).order('created_at DESC') if params[:price].present?
		@listing = Listing.all.page(params[:page]).order('created_at DESC')
		############# Refactor above code ##################
		filtering_params(params).each do |key, value|
			@listing = @listing.find_all_listing(current_user).public_send(key, value) if value.present?
		end
		####################################################
	end

	private

	def listing_params
		if params[:listing]
      		params.require(:listing).permit(:name, :description, :location, :price, :user_id, {images: []})
  		end
  	end

  	def filtering_params(params)
  		params.slice(:location, :start_name, :price)
  	end
end

################### The Existing Search #################################

		# all = Listing.page(params[:page]).order('created_at DESC')
		# if current_user.superadmin?
		# 	if params[:search].nil?
		# 		@listing = all
		# 	else
		# 		@listing = all.search(params[:search])
		# 	end
		# elsif current_user.moderator?
		# 	if params[:search].nil?
		# 		@listing = all.where(:verification => false)
		# 	else
		# 		@listing = all.search(params[:search]).where(:verification => false)
		# 	end
		# elsif current_user.customer? 
		# 	if params[:search].nil?
		# 		@listing = all.where(:verification => true)
		# 	else
		# 		@listing = all.search(params[:search]).where(:verification => false)
		# 	end
		# end
#########################################################################