class ForwardBack < Transport::Directions
  def direction_options
    @direction_options ||= [
      Direction.new('FORWARD', [1]),
      Direction.new('BACK', [-1])
    ]
  end

  def make_change(directive)
    if directive == :about_face
      self.index = (index + 1) % 2
    end
  end
end

describe ForwardBack do
  describe '#set_by_name(name)' do
    context 'when name is not one of the choices' do
      let(:name) { 'NORTH' }

      it 'returns false' do
        expect(described_class.new.set_by_name(name)).to eq false
      end
    end

    context 'when name is one of the choices' do
      let(:name) { 'FORWARD' }

      it 'returns true' do
        expect(described_class.new.set_by_name(name)).to eq true
      end
    end
  end

  context 'when #set_by_name(name) has been called with a name of one of the directions' do
    let(:directions) do
      result = described_class.new
      result.set_by_name(name)
      result
    end

    context 'when name is not a name of any of the options' do
      let(:name) { 'UP' }

      describe '#coordinates' do
        it 'returns nil' do
          expect(directions.coordinates).to be_nil
        end
      end

      describe '#to_s' do
        it 'returns empty string' do
          expect(directions.to_s).to eq ''
        end
      end

      describe '#change() called with directive it recognizes' do
        it 'does nothing to the direction' do
          expect(-> { directions.change(:about_face) }).to_not change {directions.coordinates}
        end
      end
    end

    context 'when name is name of first direction_option' do
      let(:name) { 'FORWARD' }

      describe '#coordinates' do
        it 'returns the coordinates of the direction with that name' do
          expect(directions.coordinates).to eq [1]
        end
      end

      describe '#to_s' do
        it 'returns the name' do
          expect(directions.to_s).to eq 'FORWARD'
        end
      end

      describe '#change() called with recognizable directive' do
        it 'changes direction' do
          expect { directions.change(:about_face) }.to change {directions.coordinates}
        end
      end
    end

    context 'when name is name of first direction_option' do
      let(:name) { 'BACK' }

      it 'returns the coordinates of the direction with that name' do
        expect(directions.coordinates).to eq [-1]
      end
    end
  end
end