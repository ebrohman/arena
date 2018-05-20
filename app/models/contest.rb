class Contest < ApplicationRecord
  validates :opponent_id, presence: true
  validates :challenger_id, presence: true
  validates :strategy, presence: true

  def battle
    self.winner_id = battle_strategy.run
  end

  def battle_strategy
    "Strategy::#{strategy.capitalize}"
      .constantize
      .new(opponent: find_opponent, challenger: find_challenger)
  end

  private

  def find_opponent
    BattlePet.find(opponent_id)
  rescue
    nil
  end

  def find_challenger
    BattlePet.find(challenger_id)
  rescue
    nil
  end
end
