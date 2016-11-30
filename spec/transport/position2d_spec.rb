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
  end
end