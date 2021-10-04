class User < ApplicationRecord
	has_many :posts
	has_secure_password

	validate :check_email, on: [:create ]
	validate :login, on: [:login]
	validate :edit_user, on: [:update]

	def edit_user
		@user = User.find_by(email:self.email)
		if(!@user || self.id == @user.id)
			return true
		else
			errors.add(:email,"The email already exists")
			return false
		end

	end
	def check_email
		@user = User.find_by(email:self.email)
		if(@user )
			errors.add(:email,"The email already exists")
		end

	end

	def login


		@user = User.find_by(email:self.email)

		if (!@user)
			errors.add(:email , "Your email isn't available in database")
			return false
		end


		if (@user.authenticate(self.password))
			return self.id = @user.id
		else
			errors.add(:password, "Invalid password")
			return false
		end





	end

end
