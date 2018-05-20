module Job
  class EnqueueBattle
    include Sidekiq::Worker

    class BattleError < StandardError; end

    def perform(contest_id)
      contest = Contest.find(contest_id)
      contest.battle
      contest.save!
    rescue NameError
      raise BattleError, "Invalid Battle Strategy."
    end
  end
end
