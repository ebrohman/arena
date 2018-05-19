require "rails_helper"

RSpec.describe ContestsController, type: :request do
  describe "POST" do
    context "given a valid json payload" do
      it "creates a contest" do
        post contests_url, {}
        expect(response).to be_success
      end
    end
  end
end
