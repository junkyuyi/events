class Event < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :joins, dependent: :destroy
	has_many :users_joined, through: :joins, source: :user

	validates :name, :date, :city, :state, presence: true
	validate :date_in_future

	private 
	def date_in_future
		if !date.future?
			errors.add(:date, "must be in the future")
		end
	end
end
