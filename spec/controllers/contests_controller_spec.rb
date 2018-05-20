require "rails_helper"

RSpec.describe ContestsController, type: :request do
  describe "POST" do
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

      it "creates a Contest" do
        expect { post contests_url, params: params }
          .to change { Contest.count }.by 1
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

      it "returns a helpful error message" do
        post contests_url, params: {}
        expect(response.body).to match /Opponent can't be blank/
        expect(response.body).to match /Challenger can't be blank/
      end
    end
  end
end
