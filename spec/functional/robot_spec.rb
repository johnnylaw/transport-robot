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

    context 'when placement instruction followed by MOVE and LEFT followed by REPORT' do
      let(:message) { 'PLACE 0,0,NORTH MOVE LEFT REPORT' }
      let(:expected) { "0,1,WEST\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

    context 'when robot walks into NE corner reporting on the way' do
      let(:message) do
        msg = 'PLACE 0,0,NORTH MOVE RIGHT MOVE REPORT '
        msg += 'LEFT MOVE RIGHT MOVE REPORT '
        msg += 'LEFT MOVE RIGHT MOVE REPORT '
        msg += 'LEFT MOVE RIGHT MOVE REPORT '
      end
      let(:expected) { "1,1,EAST\n2,2,EAST\n3,3,EAST\n4,4,EAST\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
        expect { robot.listen_up!('MOVE REPORT') }.to output("4,4,EAST\n").to_stdout
      end
    end

    context 'when robot walks the perimeter attempting to walk past corner each time' do
      let(:message) do
        msg = 'PLACE 0,0,NORTH REPORT '
        msg += 'MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT RIGHT '
        msg += 'MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT RIGHT '
        msg += 'MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT RIGHT '
        msg += 'MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT MOVE REPORT'
      end
      let(:expected) do
        exp = "0,0,NORTH\n0,1,NORTH\n0,2,NORTH\n0,3,NORTH\n0,4,NORTH\n0,4,NORTH\n"
        exp += "1,4,EAST\n2,4,EAST\n3,4,EAST\n4,4,EAST\n4,4,EAST\n"
        exp += "4,3,SOUTH\n4,2,SOUTH\n4,1,SOUTH\n4,0,SOUTH\n4,0,SOUTH\n"
        exp += "3,0,WEST\n2,0,WEST\n1,0,WEST\n0,0,WEST\n0,0,WEST\n"
      end

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

  end
end