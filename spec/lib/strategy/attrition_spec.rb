require "rails_helper"

RSpec.describe Strategy::Attrition do
  let(:opponent) do
    BattlePet.create(
      name: "Puffer",
      strength: 12,
      speed: 21,
      intelligence: 22,
      integrity: 66
    )
  end

  let(:challenger) do
    BattlePet.create(
      name: "Max",
      strength: 12,
      speed: 21,
      intelligence: 28,
      integrity: 69
    )
  end

  subject { described_class.new(opponent: opponent, challenger: challenger) }

  describe "#run" do
    context "when there are comparable differences in the opponents' attributes" do
      context "and the challenger should win" do
        it "returns the challenger's :id" do
          expect(subject.run).to eq(challenger.id)
        end
      end

      context "and the opponent should win" do
        let(:opponent) do
          BattlePet.create(
            name: "Puffer",
            strength: 22,
            speed: 21,
            intelligence: 22,
            integrity: 66
          )
        end

        it "returns the opponent's :id" do
          expect(subject.run).to eq(opponent.id)
        end
      end
    end

    context "when there are no comparable differences in attributes" do
      let(:opponent) do
        BattlePet.create(
          name: "Max",
          strength: 12,
          speed: 21,
          intelligence: 28,
          integrity: 69
        )
      end

      let(:possible_winners) do
        [opponent, challenger].map(&:id)
      end

      it "determines a winner randomly" do
        expect(possible_winners).to include(subject.run)
      end
    end
  end
end
