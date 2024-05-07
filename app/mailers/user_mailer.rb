class UserMailer < ApplicationMailer
	def welcome(user)
		@user = user
		mail(to: 'admin@example.com', subject: "Welcome wait for approve your request") 
	end

	def approve(user)
		@user = user 
		mail(to: @user.email, subject: " Status Appove request ")
	end
end

