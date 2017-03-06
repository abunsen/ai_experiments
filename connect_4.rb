class Connect4
  attr_reader :board

  def initialize(your_color)
    @your_color = your_color
    @board = []
    6.times do |i|
      @board[i] = []
      7.times do 
        @board[i] << nil
      end
    end
  end

  def add_move(x, y, color)
    @board[x][y] = color
  end

  def possible_moves(board)
    row = board.length-1
    moves = []
    second_empty_row = false

    while row > 0 && !second_empty_row
      col = 0
      while col < board[0].length
        if row == board.length-1
          moves << [row, col] if board[row][col].nil?
        else
          moves << [row, col] if board[row][col].nil? && !board[row+1][col].nil?
        end        
        col += 1
      end
      second_empty_row = board[row].all? {|x| x.nil?} && board[row-1].all? {|x| x.nil?}
      row -= 1
    end
    moves
  end



  def generate_move
    # check to see if your next move is a winner
    return @next_move if next_move_wins
    # now find move with max prob of winning

  end

  def next_move_wins
    win = false
    open_slots(@board).each do |x, y|
      sim_board = @board.dup

    end
  end

  def winning_board
  end

  def board_output
    print_board(@board)
  end

  def print_board(board)
    board.each do |row|
      row.each do |space|
        print "| #{space||'e'} |"
      end
      print "\n"
    end
  end
end


b = Connect4.new("red")
p b.possible_moves(b.board)
b.board_output