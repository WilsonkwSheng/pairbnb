class UsersController < ApplicationController
	before_action :require_login, except: [:create]

	def index
		@email = current_user.email
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params) # User.new(params[:user]) == User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password]
		if @user.save
			redirect_to sign_in_path
			flash[:success] = "Welcome to the Sample App!"
		else
			render "new"
			flash[:notice] = "Didnt work"
		end
	end

	def edit
	end

	private
	def user_params
      params.require(:user).permit(:name, :email, :password)
  end
end

