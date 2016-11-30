require 'matrix'
class Position3D < Vector
  def self.[](x, y, z)
    super
  end
end

describe Transport::Board do
  context 'when board is 3-dimensional with max coordinates x=4, y=4, z=10' do
    let(:board) { described_class.new(Position3D[4, 4, 10]) }

    describe '#grant_placement(player, *coordinates)' do
      context 'when coordinates are within the bounds' do
        let(:coordinates) { [1, 2, 3] }

        it 'returns true and can report on position through #position_description(player)' do
          player = Object.new
          expect(board.grant_placement(player, coordinates)).to eq true
          expect(board.position_description(player)).to eq '1,2,3'
        end
      end
    end
  end
end