module Transport
  class Robot
    include Instructable

    def initialize(board, direction = CardinalDirections.new)
      @board = board
      @direction = direction
    end

    def place(x, y, dir)
      if direction.set_by_name(dir)
        board.grant_placement(self, x, y)
      end
    end

    def move
      board.grant_advancement(self, direction.coordinates)
    end

    def right
      direction.change :right
    end

    def left
      direction.change :left
    end

    def report
      if board.has? self
        puts "#{board.position_description(self)},#{direction}"
      end
    end

    private

    attr_reader :board, :direction
  end
end