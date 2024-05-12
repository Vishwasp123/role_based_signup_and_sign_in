require 'rails_helper'

RSpec.describe User, type: :model do 
  let(:role) {create(:role) }
  let(:valid_attributes) { { name: 'Vishwas', email: 'vishwas@example.com', password: 'password', role: role } }

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should belong_to(:role) }
  end

  describe 'enums' do 
    it 'status of enum' do 
      expect(User.statuses).to eq({"approval"=>"Approval", "pending"=>"Pending"})
    end
  end

  describe 'callback' do 
    context "After  create callback" do 
      it 'send email create user' do 
        expect(UserMailer).to receive(:welcome).and_call_original
        create(:user, valid_attributes)
      end
    end

    context 'after_update' do 
      context 'when status is approval' do 
        it'send an approve email' do 
          user = create(:user, valid_attributes.merge(status: :pending))
          expect(UserMailer).to receive(:approve).and_call_original
          user.update(status: :approval)
        end
      end

      context "when status is not approval" do 
        it "does not send an email" do 
          user = create(:user, valid_attributes.merge(status: :pending))
          expect(UserMailer).not_to receive(:approve)
          user.update(name: 'New Name')
        end
      end
    end
  end

  describe '.ransackable_attributes' do 
    it 'returns an array of allowed ransackable attributes' do
      expected_attributes = ["created_at", "email", "id", "id_value", "name", "password_digest", "role_id", "status", "updated_at"]
      expect(User.ransackable_attributes).to match_array(expected_attributes)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of allowed ransackable associations' do
      expect(User.ransackable_associations).to match_array(["role"])
    end
  end
end
