class User < ApplicationRecord
	has_many :posts

	validate :check_email, on: [:create]
	validate :login, on: [:login]
	def check_email
		User.all.each do |us|
			if(us.email == self.email) 
				errors.add(:email,"The email already exists")
			end
		end
	end

	def login
		check_mail = true
		User.all.each do |us|
			if us.email == self.email && us.pass == self.pass
				return self.id = us.id
			end
			if(us.email == self.email )
				errors.add(:pass, "Invalid pass")
				return false
			end
		end	

		if check_mail 
			errors.add(:email , "Your email isn't available in database")
			return false
		end


	end

end
