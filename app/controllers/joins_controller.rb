class JoinsController < ApplicationController
	before_action :require_login
	
	def create
		Join.create(user_id: session[:user_id], event_id: params[:id])
		redirect_to "/events"
	end

	def destroy
		Join.find_by(user_id: session[:user_id], event_id: params[:id]).destroy
		redirect_to "/events"
	end
end
