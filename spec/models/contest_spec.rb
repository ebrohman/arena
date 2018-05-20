require "rails_helper"

RSpec.describe Contest do
  subject { described_class.new(attributes) }

  let(:attributes) do
    {
      opponent_id: opponent.id,
      challenger_id: challenger.id,
      strategy: "random"
    }
  end

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
      strength: 14,
      speed: 21,
      intelligence: 28,
      integrity: 69
    )
  end

  describe "#valid?" do
    context "given valid attributes" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "given no opponent_id" do
      subject { described_class.new(attributes.except(:opponent_id)) }

      it "is not valid" do
        expect(subject).not_to be_valid
      end
    end

    context "given no challenger_id" do
      subject { described_class.new(attributes.except(:challenger_id)) }

      it "is not valid" do
        expect(subject).not_to be_valid
      end
    end

    context "given no strategy" do
      subject { described_class.new(attributes.except(:strategy)) }

      it "is not valid" do
        expect(subject).not_to be_valid
      end
    end
  end

  describe "#battle_strategy" do
    context "given a strategy exists for the given strategy attribute" do
      it "instantiates it with the challenger and opponent" do
        expect(Strategy::Random).to receive(:new)
          .with( opponent: opponent, challenger: challenger)

        subject.battle_strategy
      end
    end
  end
end
