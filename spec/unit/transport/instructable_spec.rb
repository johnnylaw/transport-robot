module Distraction
  def non_method
    called.push :non_method
  end
end

class InstructableClass
  include Transport::Instructable
  include Distraction

  def move
    called.push :move
  end

  def speak
    called.push :speak
  end

  def goto(arg)
    called.push "GOTO with #{arg}"
  end

  def jump(x, y, direction)
    called.push "JUMP with #{x},#{y},#{direction}"
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
      it 'causes both of those methods to be called' do
        obj = described_class.new
        obj.listen_up!('MOVE SPEAK')
        expect(obj.called).to eq [:move, :speak]
      end
    end

    context 'when message contains a method name that -- while public -- is from another module' do
      it 'DOES NOT cause that method to be called' do
        obj = described_class.new
        obj.listen_up!('NON_METHOD')
        expect(obj.called).to be_empty
      end

      context 'when message later contains something valid' do
        it 'executes the later command' do
          obj = described_class.new
          obj.listen_up!('Poop MOVE')
          expect(obj.called).to eq [:move]
        end
      end
    end

    context 'when message contains a lowercase command' do
      it 'DOES NOT recognize the command' do
        obj = described_class.new
        obj.listen_up!('move')
        expect(obj.called).to be_empty
      end
    end

    context 'when the method expects arguments' do
      context 'when the method expects ONE argument' do
        it 'calls that method with the argument' do
          obj = described_class.new
          obj.listen_up!('GOTO 123')
          expect(obj.called).to eq ['GOTO with 123']
        end
      end

      context 'when the method expects a PLETHORA of arguments' do
        it 'calls that method with the argument' do
          obj = described_class.new
          obj.listen_up!('JUMP 123,44,UP')
          expect(obj.called).to eq ['JUMP with 123,44,UP']
        end
      end

    end
  end
end