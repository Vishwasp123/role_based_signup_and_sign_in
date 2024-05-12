require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  let(:role) {create(:role, name:"user")}
  let(:user) { create(:user, status: 'approval', password: 'password', role: role) }
  let(:unapproved_user) { create(:user, status: 'pending', password: 'password', role: role) }

  describe "Post #create" do 
    context "with valid credentials" do 
      context " when user is approved" do 
        it 'return a Jwt token' do 
          post :create, params: {email: user.email, password: user.password }
          expect(response).to have_http_status(200)
          expect(response.body).to include("token")
          expect(assigns(:user).status).to eq("approval")
        end
      end

      context"when user status pending" do 
        it "return message" do 
          post :create, params: {email: unapproved_user.email, password: "password"}
          expect(response).to have_http_status(:success)
          expect(response.body).to include("Your request has not been approved yet")
        end
      end
    end
    context"with invalid credentials" do 
      it "return an errors message" do 
        post :create, params: {email: user.email, password: "415263"}
        expect(response).not_to have_http_status(:success)
        expect(response.body).to include("Invalid credentials")
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end



