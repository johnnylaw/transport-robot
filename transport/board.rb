module Transport
  class Board
    def initialize(max_corner)
      @max_corner = max_corner
    end

    def grant_placement(player, *components)
      player_positions[player] = position_class[*components.flatten]
      true
    end

    def position_description(player)
      player_positions[player].to_a.join(',')
    end

    private

    attr_reader :max_corner

    def position_class
      @position_class ||= max_corner.class
    end

    def player_positions
      @player_positions ||= {}
    end
  end
end
