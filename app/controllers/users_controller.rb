class UsersController < ApplicationController
	before_action :require_login, except: [:create, :edit, :update]

	def index
		# @listing = Listing.find_by(user_id: current_user.id)
		@user = User.find(current_user.id)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params) # User.new(params[:user]) == User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password]
		if @user.save
			redirect_to sign_in_path
			flash[:success] = "Created the User!"
		else
			render "new"
			flash[:notice] = "Didnt work"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		params[:user].delete(:password) if params[:user][:password].blank?
		@user.update(user_params)
		redirect_to sign_in_path
	end

	private
	def user_params
      params.require(:user).permit(:name, :email, :password, :avatar)
  end
end

