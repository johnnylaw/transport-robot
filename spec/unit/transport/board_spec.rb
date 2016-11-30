require 'matrix'
class Position3D < Vector
  def self.[](x, y, z)
    super
  end
end

class PositionThatThrowArgumentError < Vector
  def self.[](x, y, z)
    raise ArgumentError if x.to_i.to_s != x.to_s
    super
  end
end

describe Transport::Board do
  context 'when board is 3-dimensional with max coordinates x=4, y=4, z=10' do
    let(:position_class) { Position3D }
    let(:board) { described_class.new(position_class[4, 4, 10]) }

    describe '#grant_placement(player, *coordinates)' do
      context 'when coordinates are within the bounds' do
        let(:coordinates) { [1, 2, 3] }

        it 'returns true and can report on position through #position_description(player)' do
          player = Object.new
          expect(board.grant_placement(player, coordinates)).to eq true
          expect(board.position_description(player)).to eq '1,2,3'
        end
      end

      context 'when coordinates are not within bounds' do
        let(:coordinates) { [1, 2, 12] }

        it 'returns false and reports empty string for position' do
          player = Object.new
          expect(board.grant_placement(player, *coordinates)).to eq false
          expect(board.position_description(player)).to eq ''
        end
      end

      context 'when called with something nutty' do
        let(:coordinates) { ['asdf', 5, 3] }
        let(:position_class) { PositionThatThrowArgumentError }

        it 'returns false and reports empty string for position' do
          player = Object.new
          expect(board.grant_placement(player, *coordinates)).to eq false
          expect(board.position_description(player)).to eq ''
        end
      end
    end
  end
end