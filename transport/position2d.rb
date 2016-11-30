require 'matrix'

module Transport
  class Position2D < Vector
    def self.[](*args)
      super(*args.map { |a| a.to_i })
    end
  end
end