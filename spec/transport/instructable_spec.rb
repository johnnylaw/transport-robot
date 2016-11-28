class InstructableClass
  include Transport::Instructable

  def move
    called.push(:move)
  end

  def speak
    called.push(:speak)
  end

  def called
    @called ||= []
  end
end

describe InstructableClass do
  describe '#listen_up!(message)' do
    context 'when message contains an uppercase command matching a public method name' do
      it 'causes that method to be called' do
        obj = described_class.new
        obj.listen_up!('MOVE')
        expect(obj.called).to eq [:move]
      end
    end

    context 'when message contains a command that DOES NOT match a public method name' do
      it 'should not raise an error' do
        obj = described_class.new
        expect(-> { obj.listen_up!('POOP') }).not_to raise_error
      end
    end

    context 'when message contains more than one an uppercase command matching a public method name' do
      it 'causes that method to be called' do
        obj = described_class.new
        obj.listen_up!('MOVE SPEAK')
        expect(obj.called).to eq [:move, :speak]
      end
    end
  end
end