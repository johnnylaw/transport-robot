module Transport
  class Board
    def initialize(max_corner)
      @max_corner = max_corner
    end

    def grant_placement(player, *components)
      position = position_class[*components.flatten]
      if on_board? position
        player_positions[player] = position
        return true
      end
      false
    rescue ArgumentError
      false
    end

    def position_description(player)
      player_positions[player].to_a.join(',')
    end

    private

    def on_board?(position)
      position.each.with_index do |d, i|
        return false unless d.between?(0, max_corner[i])
      end
      return true
    end

    attr_reader :max_corner

    def position_class
      @position_class ||= max_corner.class
    end

    def player_positions
      @player_positions ||= {}
    end
  end
end
