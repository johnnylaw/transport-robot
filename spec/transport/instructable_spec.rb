class InstructableClass
  include Transport::Instructable

  def move
    called.push(:move)
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
  end
end