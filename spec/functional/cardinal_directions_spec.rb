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
      let(:name) { 'NORTH' }

      describe '#to_s and #coordinates' do
        it 'indicates north' do
          expect(directions.to_s).to eq 'NORTH'
          expect(directions.coordinates).to eq [0, 1]
        end
      end
    end

    context 'when name is EAST' do
      let(:name) { 'EAST' }

      describe '#to_s and #coordinates' do
        it 'indicates east' do
          expect(directions.to_s).to eq 'EAST'
          expect(directions.coordinates).to eq [1, 0]
        end
      end
    end

    context 'when name is SOUTH' do
      let(:name) { 'SOUTH' }

      describe '#to_s and #coordinates' do
        it 'indicates south' do
          expect(directions.to_s).to eq 'SOUTH'
          expect(directions.coordinates).to eq [0, -1]
        end
      end
    end

    context 'when name is WEST' do
      let(:name) { 'WEST' }

      describe '#to_s and #coordinates' do
        it 'indicates west' do
          expect(directions.to_s).to eq 'WEST'
          expect(directions.coordinates).to eq [-1, 0]
        end
      end

      describe '#change' do
        it 'rotates all the way around in both directions' do
          expect { directions.change(:right) }.to change { directions.to_s }.to('NORTH')
          expect { directions.change(:right) }.to change { directions.to_s }.to('EAST')
          expect { directions.change(:right) }.to change { directions.to_s }.to('SOUTH')
          expect { directions.change(:right) }.to change { directions.to_s }.to('WEST')

          expect { directions.change(:left) }.to change { directions.to_s }.to('SOUTH')
          expect { directions.change(:left) }.to change { directions.to_s }.to('EAST')
          expect { directions.change(:left) }.to change { directions.to_s }.to('NORTH')
          expect { directions.change(:left) }.to change { directions.to_s }.to('WEST')
        end

        it 'ignores weird commands' do
          expect { directions.change(:up) }.to_not change { directions.to_s }
        end
      end
    end
  end
end