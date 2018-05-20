require "rails_helper"

RSpec.describe ContestsController, type: :request do
  describe "POST" do
    before { puts BattlePet.count }
    let(:pet_1) do
      BattlePet.create(
        name: "Puffer",
        strength: 12,
        speed: 21,
        intelligence: 22,
        integrity: 66
      )
    end

    let(:pet_2) do
      BattlePet.create(
        name: "Max",
        strength: 14,
        speed: 21,
        intelligence: 28,
        integrity: 69
      )
    end

    context "given a valid json payload" do
      let(:params) do
        {
          challenger_id: pet_1.id,
          opponent_id: pet_2.id
        }
      end

      it "returns the contest :id in the payload" do
        post contests_url, params: params
        expect(response.body).to include("id"), response.body
      end
    end

    context "given invalid params" do
      it "returns a bad request status" do
        post contests_url, params: {}
        expect(response).to be_bad_request
      end
    end
  end
end
