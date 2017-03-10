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

  def generate_move
    # check to see if your next move is a winner
    return @next_move if next_move_wins
    # now find move with max prob of winning
    "Make your move"
  end

  def next_move_wins
    possible_moves(@board).each do |x, y|
      sim_board = Marshal.load(Marshal.dump(@board))
      sim_board[x][y] = @your_color[0]
      # winning = has_winner(sim_board) ? "winning" : "losing"
      # puts "-" * 10
      # puts "#{winning} FAKE BOARD for [#{x}, #{y}]"
      # print_board(sim_board)
      # puts "-" * 10
      if has_winner(sim_board)
        @next_move = [x, y]
        return true 
      end
    end
    false
  end

  def has_winner(board)
    # possible_wins = ["vertical", "horizontal", "left_diagonal", "right_diagonal"]
    # check horizontal
    board.each do |row|
      color_count = 0
      last_color = nil
      row.each do |spot|
        if last_color && spot == last_color
          color_count += 1
        else
          color_count = 1
        end
        last_color = spot if spot
        return last_color if color_count > 3
      end
    end

    # check vertical
    i = 0
    while i < board.first.length
      color_count = 0
      last_color = nil
      j = 0 
      while j < board.length
        spot = board[j][i]
        if last_color && spot == last_color
          color_count += 1
        else
          color_count = 1
        end
        last_color = spot if spot
        return last_color if color_count > 3
        j += 1
      end
      i += 1
    end

    # left diag
    # first 3 rows
    # first 4 cols as starting points
    board[0..2].each_with_index do |row_obj, row_index|
      row_obj[0..3].each_with_index do |spot, col_index|
        row = row_index
        col = col_index
        color_count = 0
        last_color = nil
        4.times do |i|
          spot = board[row][col]
          if last_color && spot == last_color
            color_count += 1
          else
            color_count = 1
          end
          last_color = spot if spot
          return last_color if color_count > 3
          row += 1
          col += 1
        end
      end
    end

    # right diag
    # last 3 rows
    # first 4 cols as starting points
    board[0..2].each_with_index do |row_obj, row_index|
      row_obj[4..6].each_with_index do |spot, col_index|
        row = row_index
        col = col_index+4
        color_count = 0
        last_color = nil
        4.times do |i|
          spot = board[row][col]
          if last_color && spot == last_color
            color_count += 1
          else
            color_count = 1
          end
          last_color = spot if spot
          return last_color if color_count > 3
          row += 1
          col -= 1
        end
      end
    end
    
    false
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

  def possible_moves(board)
    # look at spaces around placed pieces, recursively.
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
end


b = Connect4.new("red")
p b.possible_moves(b.board)
b.board_output

input = gets.chomp
until input == "q"
  if input.start_with?("y:") || input.start_with?("r:")
    color = input.split(":").first
    x,y = *input.split(":")[1].split(",").map(&:to_i)
    b.add_move(x,y,color)
  end
  b.board_output
  p b.generate_move if color == "y"
  input = gets.chomp
end