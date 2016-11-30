describe Transport::Robot do
  context 'when board is 5x5 (max @ 4, 4)' do
    let(:board) { Transport::Board.new(Transport::Position2D[4, 4]) }
    let(:robot) { Transport::Robot.new(board) }

    context 'when message is just REPORT' do
      let(:message) { 'REPORT' }

      it do
        expect { robot.listen_up!(message) }.to_not output.to_stdout
      end
    end

    context 'when message is a simple placement followed by REPORT' do
      let(:message) { 'PLACE 1,2,EAST REPORT' }
      let(:expected) { "1,2,EAST\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

    context 'when message is a botched placement instruction followed by REPORT' do
      let(:message) { 'PLACE 1,2,xAST REPORT' }

      it do
        expect { robot.listen_up!(message) }.to_not output.to_stdout
      end
    end

    context 'when placement instruction followed by bad placement followed by REPORT' do
      let(:message) { 'PLACE 3,4,NORTH PLACE 1,2,xAST REPORT' }
      let(:expected) { "3,4,NORTH\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

    context 'when placement instruction followed by MOVE followed by REPORT' do
      let(:message) { 'PLACE 0,0,NORTH MOVE REPORT' }
      let(:expected) { "0,1,NORTH\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

    context 'when placement instruction followed by MOVE and RIGHT followed by REPORT' do
      let(:message) { 'PLACE 0,0,NORTH MOVE RIGHT REPORT' }
      let(:expected) { "0,1,EAST\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

  end
end