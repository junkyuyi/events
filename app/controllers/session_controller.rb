class SessionController < ApplicationController
	before_action :require_login, except: [ :create ]

	def create
		@user = User.find_by_email( params[:email] )
		if @user.nil? or  !@user.authenticate params[:password]
			flash[:errors] = ["Invalid"]
			redirect_to "/"
		else
			session[:user_id] = @user.id
			redirect_to "/events"
		end 
	end


	def destroy
		session[:user_id] = nil
		redirect_to "/"
	end
end
