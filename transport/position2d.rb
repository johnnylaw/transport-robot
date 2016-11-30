require 'matrix'

module Transport
  class Position2D < Vector
    def self.[](x, y)
      super(Integer(x), Integer(y))
    end
  end
end