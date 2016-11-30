require 'matrix'

module Transport
  class Position2D < Vector
    def self.[](*args)
      super(*args.map { |a| Integer(a) })
    end
  end
end