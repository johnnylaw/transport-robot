describe Transport::CardinalDirections do
  context 'when set_by_name has been called' do
    let(:directions) do
      result = described_class.new
      result.set_by_name(name)
      result
    end

    context 'when name is not NORTH, EAST, SOUTH, or WEST' do
      let(:name) { 'UP-DOWN-ALL-AROUND' }

      describe '#to_s and #coordinates' do
        it 'indicates direction not set' do
          expect(directions.to_s).to eq ''
          expect(directions.coordinates).to eq [0, 0]
        end
      end
    end

    context 'when name is NORTH' do
    end
  end
end