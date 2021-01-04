require_relative '../lib/tic_tac_toe/game'
require_relative '../lib/tic_tac_toe/instructions'
require_relative '../lib/tic_tac_toe/player'

describe

describe Game do
  describe '#win' do
    context 'when a player has one straight line on the board' do
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

      it "it doesn\'t changes @winner variable if there is no straight line" do
        winner_name = 'Charles'
        moves = [1, 2, 4]
        game_win.win(moves, winner_name)
        winner = game_win.winner
        expect(winner).to_not eq('Charles')
      end
    end

    context 'when there are no more moves and no line on the board' do
      subject(:game_draw) { described_class.new }
      let(:player) { instance_double(Player) }

      it "changes @winner to \'draw\'" do
        moves = [1, 2, 4]
        game_draw.game = ['X', 'O', 'X', 'O', 'O', 'X', 'X', 'X', 'O']
        game_draw.win(moves, player)
        winner = game_draw.winner
        expect(winner).to eq('draw')
      end
    end
  end
end
