class Contest < ApplicationRecord
  validates :opponent_id, presence: true
  validates :challenger_id, presence: true
  validates :strategy, presence: true

  def battle
    self.winner_id = battle_strategy.run
  end

  def battle_strategy
    @_strategy ||= "Strategy::#{strategy.capitalize}"
      .constantize
      .new(opponent: find_opponent, challenger: find_challenger)
  end

  def validate_opposition!
    find_opponent
    find_challenger
  end

  private

  def find_opponent
    @opponent ||= BattlePet.find(opponent_id)
  end

  def find_challenger
    @challenger ||= BattlePet.find(challenger_id)
  end
end
