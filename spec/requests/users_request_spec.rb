require 'rails_helper'
include JsonWebToken

RSpec.describe "Users", type: :request do

  let(:valid_params) {{
    "user": {
      "name": "Sachin",
      "email": "sachin@gmail.com",
      "phone_number": 7999498437,
      "username": "sachin",
      "country_code": 91,
      "password": "123456"     
    }
  }}
 
 
  let(:invalid_params) {{
    "user": {
      "name": "Sachin",
      "email": "",
      "phone_number": 7999498437,
      "username": "",
      "country_code": 91,
      "password": "123456"     
    }
  }}
	  

  describe "GET index" do

     context "index action" do 
     	it "renders the errors" do
     		get "/users"
     		expect(response).to have_http_status(:bad_request)
     	end
   	end

    context "index action" do 
      let!(:user) { FactoryBot.create(:user) }
      it "renders the index template" do
        get "/users"
        expect(response).to have_http_status(:ok)
      end
    end

  end

 	describe 'POST create' do

    context "create action" do
   		it "creates the user" do
   			post "/users", params: valid_params
   			expect(response).to have_http_status(:created)
   		end
    end

    context "create action" do
      it "creates error for invalid_user" do
        post "/users", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
 	end

  describe "For Authenticated User" do
    let!(:user) {FactoryBot.create(:user, activated: true)}
    let!(:token_new) {Jwt.jwt_encode({user_id: user.id}, 7.days.from_now)}
    let(:token) do
      {  "Authorization": "#{token_new}"  }
    end

    describe "GET show" do
      context "show action" do
        it "show user data" do
          get user_path(user.id), params: {}, headers: token 
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "PUT update" do
      context "update action" do
        it "will update user" do
          put user_path(user.id), params: valid_params, headers: token
          expect(response).to have_http_status(:ok)
        end
      end

      context "update action" do
        it "will not update user" do
          put user_path(user.id), params: invalid_params, headers: token
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE action" do
      context "destroy action" do
        it "will destroy user" do
          delete user_path(user.id), params: {}, headers: token
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end


end