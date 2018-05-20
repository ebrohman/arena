module Command
  class ShowContest
    def call(id)
      @contest = Contest.find(id) rescue nil
    end

    def status
      return 200 if contest
      404
    end

    def to_json
      (contest || {}).to_json
    end

    private

    attr_accessor :contest
  end
end
