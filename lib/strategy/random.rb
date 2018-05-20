module Strategy
  class Random
    attr_accessor :opponent, :challenger

    def initialize(opponent:, challenger:)
      @opponent, @challenger = opponent, challenger
    end

    def run
      [opponent.id, challenger.id].sample
    end
  end
end
