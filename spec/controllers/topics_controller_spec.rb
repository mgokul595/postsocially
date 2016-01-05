require 'rails_helper'
require 'support/factory_girl'
require 'factories'

RSpec.describe TopicsController, type: :controller do
  describe "GET#new" do
    it "sign_in user" do

      user1=create(:user)
      sign_in :user, user1

      get "new"
      expect(response).to render_template(:new)

    end
  end
end