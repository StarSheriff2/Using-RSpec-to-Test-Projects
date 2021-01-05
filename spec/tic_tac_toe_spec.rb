require_relative '../lib/tic_tac_toe/game'
require_relative '../lib/tic_tac_toe/instructions'
require_relative '../lib/tic_tac_toe/player'

describe Game do
  describe '#win' do
    context 'when player has one straight line on the board' do
      subject(:game_win) { described_class.new }

      it "changes @winner to player's name" do
        winner_name = 'Charles'
        moves = [1, 2, 3]
        game_win.win(moves, winner_name)
        winner = game_win.winner
        expect(winner).to eq('Charles')
      end

      it "changes @winner to player's name if line is in reverse order" do
        winner_name = 'Charles'
        moves = [3, 2, 1]
        game_win.win(moves, winner_name)
        winner = game_win.winner
        expect(winner).to eq('Charles')
      end
    end

    context 'when player has no straight line on the board' do
      subject(:game) { described_class.new }

      it "it doesn\'t changes @winner variable" do
        current_player = 'Charles'
        moves = [1, 2, 4]
        game.win(moves, current_player)
        winner = game.winner
        expect(winner).to_not eq('Charles')
      end
    end

    context 'when there are no moves left and no straight line on the board' do
      subject(:game_draw) { described_class.new }
      let(:player) { instance_double(Player) }

      it "changes @winner to \'draw\'" do
        moves = [1, 2, 4]
        game_draw.game = %w[X O X O O X X X O]
        game_draw.win(moves, player)
        winner = game_draw.winner
        expect(winner).to eq('draw')
      end
    end

    context 'when a player has made less than 3 moves' do
      subject(:game_less_moves) { described_class.new }
      let(:player) { instance_double(Player) }
      let(:winning_combinations) { object_double('Game::WINNING_COMBINATIONS').as_stubbed_const }

      it 'does not send each' do
        moves = [1, 2]
        expect(winning_combinations).to_not receive(:each)
        game_less_moves.win(moves, player)
      end

      it 'does not change state of winner' do
        moves = [1, 2]
        game_less_moves.win(moves, player)
        winner = game_less_moves.winner
        expect(winner).to be(nil)
      end
    end
  end

  describe '#turn' do
    subject(:game_turn) { described_class.new }

    it 'returns string if move is not > 9 or is < 0' do
      error_message = "error! Please select any number from 1 to 9\n"
      player = instance_double(Player)
      result = game_turn.turn(10, player)
      expect(result).to eq(error_message)
    end

    it 'returns string if position is marked' do
      error_message = "error! That position is already taken\n"
      game_turn.game = %w[X O X]
      player = instance_double(Player)
      result = game_turn.turn(2, player)
      expect(result).to eq(error_message)
    end

    context 'when user\'s position input is valid' do
      let(:player) { instance_double(Player, name: 'Johnny', moves: [1, 4]) }

      before do
        allow(game_turn).to receive(:win)
        allow(player).to receive(:symbol)
      end

      it 'returns a string' do
        text = "\nJohnny, you selected position 3. Now your move is displayed on the board.\n"
        result = game_turn.turn(3, player)
        expect(result).to eq(text)
      end
    end
  end

  describe '#change_turn' do
    subject(:game_change_turn) { described_class.new }

    it 'changes player_turn to 1 if player_turn has a value of 0' do
      game_change_turn.change_turn
      player_turn = game_change_turn.player_turn
      expect(player_turn).to eq(1)
    end
  end
end
