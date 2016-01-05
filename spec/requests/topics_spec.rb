require 'rails_helper'
require 'support/factory_girl'
require 'factories'

RSpec.describe TopicsController, type: :request do
  describe "Create new Topic - " do
    it "sign_in user" do
      user1=create(:user)
      post "/users/sign_in", :user=>{email: user1.email, password: user1.password}
     #sign_in :user, user1

      get "/topics/new"
      expect(response).to render_template(:new)

      post "/topics", :topic=>attributes_for(:topic)

      expect(assigns(:topic)).to be_a(Topic)
      expect(response).to redirect_to(Topic.last)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("Topic was successfully created.")
    end
  end
end