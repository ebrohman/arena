require "rails_helper"

RSpec.describe ContestsController, type: :request do
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

  let(:create_params) do
    {
      challenger_id: pet_1.id,
      opponent_id: pet_2.id
    }
  end

  describe "POST" do
    context "given a valid json payload" do
      it "creates a Contest" do
        expect { post contests_url, params: create_params }
          .to change { Contest.count }.by 1
      end

      it "returns the contest :id in the payload" do
        post contests_url, params: create_params
        expect(response.body).to include("contest_id"), response.body
      end
    end

    context "given invalid params - no ids" do
      it "returns a 404" do
        post contests_url, params: {}
        expect(response.status).to eq 404
      end

      it "returns a helpful error message" do
        post contests_url, params: {}
        expect(response.body).to match /Couldn't find BattlePet with 'id'=/
      end
    end

    context "given an invalid battle strategy" do
      before { post contests_url, params: create_params.merge(strategy: "foobar") }

      it "returns helpful information" do
        expect(response.body).to match /Invalid Battle Strategy/
      end

      it "returns a 400 bad request" do
        expect(response).to be_bad_request
      end
    end

    context "given invalid (non-existant) battle pet ids (opponent and challenger)" do
      let(:create_params) do
        {
          challenger_id: SecureRandom.uuid,
          opponent_id: SecureRandom.uuid
        }
      end

      it "returns a 404" do
        post contests_url, params: create_params
        expect(response.status).to eq 404
      end
    end
  end

  describe "GET" do
    context "given a valid :id for Contest" do
      before do
        post contests_url, params: create_params
        @contest_id = Oj.load(response.body)["id"]
      end

      it "retreives the contest" do
        get contests_url, params: { id: @contest_id }
        expect(Oj.load(response.body)["id"]).to eq @contest_id
      end
    end

    context "given an invalid :id" do
      it "returns a 404" do
        get contests_url
        expect(response).to be_not_found
      end
    end
  end
end
