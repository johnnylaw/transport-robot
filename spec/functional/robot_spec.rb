describe Transport::Robot do
  context 'when board is 5x5 (max @ 4, 4)' do
    let(:board) { Transport::Board.new(Transport::Position2D[4, 4]) }
    let(:robot) { Transport::Robot.new(board) }

    context 'when message is a simple placement followed by REPORT' do
      let(:message) { 'PLACE 1,2,EAST REPORT' }
      let(:expected) { "1,2,EAST\n" }

      it do
        expect { robot.listen_up!(message) }.to output(expected).to_stdout
      end
    end

  end
end