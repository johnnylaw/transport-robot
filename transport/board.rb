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

    def grant_advancement(player, *coordinates)
      if has? player
        proposed = player_positions[player] + position_class[*coordinates.flatten]
        player_positions[player] = proposed if on_board?(proposed)
      end
    end

    def position_description(player)
      player_positions[player].to_a.join(',')
    end

    def remove(player)
      player_positions.delete(player)
    end

    def has?(player)
      player_positions.has_key?(player)
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
