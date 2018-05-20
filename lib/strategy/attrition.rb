module Strategy
  class Attrition
    BATTLE_ATTRS = %w[ strength speed intelligence integrity ].freeze
    attr_accessor :opponent, :challenger

    def initialize(opponent:, challenger:)
      @opponent, @challenger = opponent, challenger
    end

    def run
      challenger.attributes.each do |c_key, c_value|
        opponent.attributes.each do |o_key, o_value|
          next unless [c_key, o_key].all? { |k| BATTLE_ATTRS.include? k }
          next unless c_key == o_key
          return challenger.id if c_value > o_value
          return opponent.id if o_value > c_value
        end
      end

      Strategy::Random.new(opponent: opponent, challenger: challenger).run
    end
  end
end
