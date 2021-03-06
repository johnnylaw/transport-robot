describe Transport::Position2D do
  describe '.[](x, y)' do
    context 'when x and y are integers' do
      let(:x) { 5 }
      let(:y) { 7 }

      it 'returns a Position2D with components x and y' do
        position = described_class[x, y]
        expect(position[0]).to eq x
        expect(position[1]).to eq y
      end
    end

    context 'when x and y are strings that can be cast into integers' do
      let(:x) { '5' }
      let(:y) { '7' }

      it 'returns a Position2D with components x.to_i and y.to_i' do
        position = described_class[x, y]
        expect(position[0]).to eq x.to_i
        expect(position[1]).to eq y.to_i
      end
    end

    context 'when either x or y cannot be cast into integers' do
      let(:x) { 'asdf' }
      let(:y) { 7 }

      it 'raises an ArgumentError' do
        expect(-> { described_class[x, y] }).to raise_error(ArgumentError, 'invalid value for Integer(): "asdf"')
      end
    end

    context 'when more than two arguments are given' do
      let(:args) { [1, 2, 3] }

      it 'raises an ArgumentError' do
        expect(-> { described_class[*args] }).to raise_error(ArgumentError, 'wrong number of arguments (3 for 2)')
      end
    end
  end

  describe '#to_s' do
    it 'gives the two values comma separated' do
      expect(described_class[5, 7].to_s).to eq '5,7'
    end
  end

  describe 'conditional initializer Transport.Position2D(x, y)' do
    context 'when valid arguments given for x and y' do
      let(:x) { 5 }
      let(:y) { 7 }

      it 'returns a Position2D with expected components' do
        position = Transport.Position2D(x, y)
        expect(position[0]).to eq x
        expect(position[1]).to eq y
      end
    end

    context 'when known invalid argument given for x or y' do
      let(:x) { 7 }
      let(:y) { 'asdf' }

      it 'returns nil' do
        expect(Transport.Position2D(x, y)).to be_nil
      end
    end
  end
end
