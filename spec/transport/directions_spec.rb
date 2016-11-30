class PoorlyImplementedDirectionsSubclass < Transport::Directions
end

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

describe PoorlyImplementedDirectionsSubclass do
  describe '#direction_options' do
    it 'raises an error' do
      expect(-> { described_class.new.direction_options }).to raise_error(
        NotImplementedError, 'Subclasses of Directions must implement #direction_options method'
      )
    end
  end

  describe '#change' do
    it 'raises an error' do
      expect(-> { described_class.new.change }).to raise_error(
        NotImplementedError, 'Subclasses of Directions must implement #make_change method'
      )
    end
  end
end

describe ForwardBack do
  context 'when #set_by_name(name) has been called with a name of one of the directions' do
    let(:directions) do
      result = described_class.new
      result.set_by_name(name)
      result
    end

    describe '#coordinates' do
      context 'when name is name of first direction_option' do
        let(:name) { 'FORWARD' }

        it 'returns the coordinates of the direction with that name' do
          expect(directions.coordinates).to eq [1]
        end
      end
    end
  end
end