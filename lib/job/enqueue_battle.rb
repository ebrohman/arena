module Job
  class EnqueueBattle
    include Sidekiq::Worker

    def perform(contest_id)
      contest = Contest.find(contest_id)
      contest.battle
      contest.save!
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
