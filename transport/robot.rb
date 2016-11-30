module Transport
  class Robot
    include Instructable

    def initialize(board, direction = CardinalDirections.new)
      @board = board
      @direction = direction
    end

    def place(x, y, dir)
      direction.set_by_name(dir)
      board.grant_placement(self, x, y)
    end

    def report
      puts "#{board.position_description(self)},#{direction}"
    end

    private

    attr_reader :board, :direction
  end
end