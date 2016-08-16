class UsersController < ApplicationController
	before_action :require_login, except: [ :create, :new ]

	def new
	
	end

	def create
		@user = User.create( user_params )
		flash[:errors] = @user.errors.full_messages unless @user.valid?
		if flash[:errors]
			redirect_to "/"
		else
			session[:user_id] = @user.id
			redirect_to "/events"
		end 
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		@user.update( user_params )
		flash[:errors] = @user.errors.full_messages unless @user.valid?
		if flash[:errors]
			redirect_to "/users/#{session[:user_id]}/edit"
		else
			redirect_to "/events"
		end 
	end

	def user_params
		params.require(:user).permit(	
			:first_name, 
			:last_name, 
			:email,
			:city,
			:state,
			:password, 
			:password_confirmation)
	end
end
