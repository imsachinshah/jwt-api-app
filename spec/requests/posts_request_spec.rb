require 'rails_helper'
include JsonWebToken

RSpec.describe "Posts", type: :request do
	let(:user) {FactoryBot.create(:user, activated: true)}
	let(:new_token) {Jwt.jwt_encode({user_id: user.id}, 7.days.from_now)}
	let(:token) {{"Authorization": new_token}}

	let(:valid_params) {{
    "post": {
      "title": "Title of the Posts",
      "desc": "This is description",    
    }
  }}
  let(:invalid_params) {{
    "post": {
      "title": "",
      "desc": "This is description",    
    }
  }}

	describe 'GET index' do
		context "index action" do
			let!(:post) {FactoryBot.create(:post, user_id: user.id)}
			it "will render posts" do
				get posts_path, params: {}, headers: token
				expect(response).to have_http_status(:ok)
			end
		end
		context "index action" do
			it "will render no posts messages" do
				get posts_path, params: {}, headers: token
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

	describe 'POST create' do
		context 'create action' do
			it "will create post" do
				post '/posts/', params: valid_params, headers: token
				expect(response).to have_http_status(:created)
			end
		end

		context 'create action' do
			it "will not create post" do
				post '/posts/', params: invalid_params, headers: token
				expect(response).to have_http_status(:unprocessable_entity)
			end
		end
	end

	describe 'For one post actions' do 
		let(:post) {FactoryBot.create(:post, user_id: user.id)}
		describe "GET show" do
			context 'show action' do
				it "will show post" do
					get post_path(post), params: {}, headers: token
					expect(response).to have_http_status(:ok)
				end
			end
		end

		describe "PUT update" do
			context 'update action' do
				it "will update post" do
					put post_path(post), params: valid_params, headers: token
					expect(response).to have_http_status(:ok)
				end
			end
		end

		describe 'DELETE destroy' do
			context 'destroy action' do
				it "will destroy post" do 
					delete post_path(post), params: {}, headers: token
					expect(response).to have_http_status(:ok)
				end
			end
		end
	end
end