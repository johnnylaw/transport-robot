require File.expand_path('../directions', __FILE__)

module Transport
  class CardinalDirections < Directions
    def direction_options
      @direction_options ||= [
      ]
    end

    def coordinates
      [0, 0]
    end

  end
end