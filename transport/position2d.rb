require 'matrix'

module Transport
  class Position2D < Vector
    def self.[](x, y)
      super(Integer(x), Integer(y))
    end

    def to_s
      to_a.join(',')
    end
  end

  def self.Position2D(*args)
    Position2D[*args]
  rescue ArgumentError
  end
end