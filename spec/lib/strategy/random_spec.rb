require "rails_helper"

RSpec.describe Strategy::Random do
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

  let(:possible_winners) do
    [pet_1, pet_2].map(&:id)
  end

  subject { described_class.new(opponent: pet_1, challenger: pet_2) }

  describe "#run" do
    it "returns an :id of either the opponent or challenger at random" do
      expect(possible_winners).to include(subject.run)
    end
  end
end
