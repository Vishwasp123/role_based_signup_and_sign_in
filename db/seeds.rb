# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') 

Role.create(name: "user")


{
    "user": {
        "name": "user3",
        "email": "user3@gmail.com",
        "role_id": 1,
        "status": "pending",
        "password": "123456"

    }
}
