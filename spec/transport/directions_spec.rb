class PoorlyImplementedDirectionsSubclass < Transport::Directions
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