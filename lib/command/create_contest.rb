module Command
  class CreateContest
    attr_reader :errors, :status

    CONTEST_PARAMS = %i( opponent_id challenger_id strategy).freeze

    def call(params)
      create_contest(params)

      contest.save if contest.validate_opposition! && contest.valid?

    rescue ActiveRecord::RecordNotFound => e
      @errors = e.message
      @status = 404
    end

    def contest_id
      contest.id
    end

    def to_json
      { contest_id: contest.id }
    end

    private

    attr_writer :errors, :status
    attr_accessor :contest

    def create_contest(params)
      @contest = Contest.new(
        strategy: params[:strategy] || "random",
        opponent_id: params[:opponent_id],
        challenger_id: params[:challenger_id]
      )
    end
  end
end
