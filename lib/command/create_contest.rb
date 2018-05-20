module Command
  class CreateContest
    attr_reader :errors

    CONTEST_PARAMS = %i( opponent_id challenger_id strategy).freeze

    def call(params)
      create_contest(params)

      unless contest.valid?
        @errors = contest.errors.full_messages
        return
      end

      contest.save
      contest.id
    end

    def status
      return 201 if contest.valid?
      400
    end

    def to_json
      { id: contest.id }
    end

    private

    attr_writer :errors
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
