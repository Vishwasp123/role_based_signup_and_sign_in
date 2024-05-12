FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    role_id { 1 }
    password_digest {"123456"}
    status {"pending"}
  end
end
