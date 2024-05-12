class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true
	
	belongs_to :role

	after_create :sending_create_email
	after_update :sending_update_email 

	enum status: {pending: 'Pending', approval: 'Approval'}

	def self.ransackable_attributes(auth_object = nil)
		["created_at", "email", "id", "id_value", "name", "password_digest", "role_id", "status", "updated_at"]
	end
	def self.ransackable_associations(auth_object = nil)
		["role"]
	end

	private
	def sending_create_email
		UserMailer.welcome(self).deliver_now
	end

	def sending_update_email
		if  status == 'approval'
			UserMailer.approve(self).deliver_now
		end
	end
end
