class PlacementClass
  def initialize(direction, *args)
    raise ArgumentError if direction == :error
    @vector = args
  end

  def on_axis(num)
    @vector[num]
  end

end

describe Transport::Board do
  let(:dimensions) { [4, 6] }
  let(:placement_class) { PlacementClass }

  describe '#placement_for_coordinates' do
    context 'when both coordinates are inside the board' do
      let(:coordinates) { [4, 7] }

      it 'returns nil' do
        placement = described_class.new(dimensions, placement_class).placement_for_coordinates('some direction', *coordinates)
        expect(placement).to be_a PlacementClass
      end
    end
  end
end