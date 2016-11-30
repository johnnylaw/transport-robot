require File.expand_path('../directions', __FILE__)

module Transport
  class CardinalDirections < Directions
    def direction_options
      @direction_options ||= [
        Direction.new('NORTH', [ 0,  1]),
        Direction.new('EAST',  [ 1,  0]),
        Direction.new('SOUTH', [ 0, -1]),
        Direction.new('WEST',  [-1,  0]),
      ]
    end

    def coordinates
      super || [0, 0]
    end

    def make_changes(directive)
    end
  end
end