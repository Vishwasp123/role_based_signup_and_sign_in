require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:role) { create(:role) }
  let(:valid_attributes) { { name: 'Vishwas', email: 'vishwas@example.com', password: 'password', role_id: role.id, status: "pending" } }
  let(:invalid_attributes) { attributes_for(:user, name: nil, role_id: nil, password: nil) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do

        expect {
          post :create, params: { user: valid_attributes }
        }.to change { User.count }.by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Wait for Admin Approve Request")
        expect(response.body).to include("Vishwas") 
        expect(response.body).to include("vishwas@example.com")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity name" do
        post :create, params: { user: invalid_attributes }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Name can't be blank")
        expect(response.body).to include("Password can't be blank")
        expect(JSON.parse(response.body)["errors"]).to include("Role must exist")
      end
    end

    context "valid params" do 
      it "create a new user" do 
        expect{
          post :create, params: {user: valid_attributes}
        }.to change { User.count }.by(1)
        expect(response.body).to include("Wait for Admin Approve Request")
      end

      it "permitted correct parameters" do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user).name).to eq('Vishwas')
        expect(assigns(:user).email).to eq('vishwas@example.com')
        expect(assigns(:user).role_id).to eq(role.id)
        expect(assigns(:user).password).to eq('password')
        expect(assigns(:user).status).to eq('pending')
      end
    end
  end

  
end
