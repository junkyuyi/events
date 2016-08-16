class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	has_many :events
	has_many :comments
	has_many :joins, dependent: :destroy
	has_many :events_joined, through: :joins, source: :event

	has_secure_password
	validates :first_name, :last_name, :email, :city, :state, presence: true
	validates :email, :uniqueness => true, :format => { :with => EMAIL_REGEX }
	validates :password, length: { minimum: 8 }, on: :create
	before_validation :downcase_email

	private
	def downcase_email
		self.email.downcase! unless self.email.blank?
	end
end
