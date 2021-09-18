class User < ApplicationRecord
	has_many :posts

	validate :check_email, on: [:create,:update]

	def check_email
		User.all.each do |us|
			if(us.name == self.name) 
				errors.add(:email,"The email already exists")
			end
		end
	end
end
