class EventsController < ApplicationController
	before_action :require_login

	def create
		@event = Event.new( event_params )
		@event.user = current_user
		@event.save
		flash[:errors] = @event.errors.full_messages unless @event.valid?	
		redirect_to "/events"
	end

	def index
		@user = current_user
		state = @user.state
		puts state

		@state_events = Event.where(state: state).order('date DESC')
		@outter_events = Event.where.not(state: state).order('date DESC')
	end

	def show
		@event = Event.find(params[:id])
		@joined = @event.users_joined
		@comments = @event.comments.order('created_at ASC')
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to "/events"
	end

	private

	def event_params
		params.require(:event).permit(	
			:name, 
			:date,
			:city,
			:state)
	end

end
