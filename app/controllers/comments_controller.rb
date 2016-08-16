class CommentsController < ApplicationController
	before_action :require_login
	
	def create
		@comment = Comment.new( comment_params )
		@comment[:user_id] = session[:user_id]
		@comment.save

		flash[:errors] = @comment.errors.full_messages unless @comment.valid?
		redirect_to "/events/#{params[:comment][:event_id]}"
	end

	private 

	def comment_params
		params.require(:comment).permit(:comment, :event_id)
	end
end
