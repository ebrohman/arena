module Command
  class CreateContest

    attr_reader :contest

    CONTEST_PARAMS = %i[ opponent_id challenger_id strategy].freeze

    def call(params)
      # byebug
      @contest = Contest.new(
        strategy: params[:strategy] || "random",
        opponent_id: params[:opponent_id],
        challenger_id: params[:challenger_id]
      )

      contest.battle
      contest.save!
      contest.id
    rescue ActiveRecord::RecordInvalid => e
      nil
    end

    def status
      return 201 if contest.valid?
      400
    end

    def to_json
      { id: contest.id }
    end
  end
end
