require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do 
    it { should validate_presence_of(:email)}
  end

  describe '.ransackable_attributes' do 
    it 'returns an array of allowed ransackable attributes' do 
     expected_attributes = [
      "created_at",
      "email",
      "encrypted_password",
      "id",
      "id_value",
      "remember_created_at",
      "reset_password_sent_at",
      "reset_password_token",
      "updated_at"
    ]
    expect(AdminUser.ransackable_attributes).to match_array(expected_attributes)
  end
end

describe 'devise modules' do 
  it 'includes database_authenticatable' do 
    expect(AdminUser.devise_modules).to include(:database_authenticatable)
  end
  it 'includes recoverable' do 
    expect(AdminUser.devise_modules).to include(:recoverable)
  end

  it 'include remember' do 
    expect(AdminUser.devise_modules).to include(:rememberable)
  end

  it 'include validates' do 
    expect(AdminUser.devise_modules).to include(:validatable)
  end
end

describe 'validations' do
  subject { build(:admin_user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
end
