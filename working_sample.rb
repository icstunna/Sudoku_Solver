class Sudoku


  def initialize(board_string, current_index = nil)
    @master_board = board_string.split("")
    @current_index = current_index
    @possible_numbers = ["1","2","3","4","5","6","7","8","9"]
  end

  def solve
  end

  def find_blank_cell
    @current_index = @master_board.find_index("-")
  end

  def get_row_number(cell_index)
     cell_index / 9
  end

  def get_column_number(cell_index)
     cell_index % 9
  end

  def get_box_number(cell_index)
     ((cell_index/9)/3) + ((cell_index%9)/3) * 3
  end

  def get_numbers_in_row(current_index)
    numbers_in_row = []
    @master_board.each_with_index do |cell_contents, index|
     if get_row_number(current_index) == get_row_number(index)
       numbers_in_row << cell_contents
     end
    end
    numbers_in_row.reject! { |number| number == "-"}
    return numbers_in_row
  end

  def get_numbers_in_column(current_index)
    numbers_in_column = []
    @master_board.each_with_index do |cell_contents, index|
     if get_column_number(current_index) == get_column_number(index)
       numbers_in_column << cell_contents
     end
    end
    numbers_in_column.reject! { |number| number == "-"}
    return numbers_in_column
  end

  def get_numbers_in_box(current_index)
    numbers_in_box = []
    @master_board.each_with_index do |cell_contents, index|
     if get_box_number(current_index) == get_box_number(index)
       numbers_in_box << cell_contents
     end
    end
    numbers_in_box.reject! { |number| number == "-"}
    return numbers_in_box
  end

  def all_corresponding_nums(numbers_in_row, numbers_in_column, numbers_in_box)
    return all_corresponding_nums = numbers_in_row + numbers_in_column + numbers_in_box
  end

  def non_corresponding_nums (all_corresponding_nums)
    @possible_numbers - all_corresponding_nums
  end

  def singular_cell_answer()

  end

  def display_board
    puts @master_board.each_slice(9).to_a.map { |cell|
      cell.map { |cell|
        cell.ljust(2)
      }.join
    }
  end


  def is_empty?(singular_cell)
    singular_cell == "-"
  end

  def solve
    until solved?
      @master_board.each_with_index do |cell_contents, index|
        if is_empty?(cell_contents)
        non_related_values = non_corresponding_nums(all_corresponding_nums(get_numbers_in_row(index), get_numbers_in_column(index), get_numbers_in_box(index)))
          if non_related_values.length == 1
            @master_board[index] = non_related_values[0]
          end
        end
      end
    end
    display_board
  end

  def solved?
    if !@master_board.include?("-")
      return true
    end
    return false
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
  end

end

test_input = "--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3"

test_board = Sudoku.new(test_input)
#test_board.find_blank_cell
#p test_board.get_numbers_in_row(0)
#p test_board.all_corresponding_nums(test_board.get_numbers_in_row(5),test_board.get_numbers_in_column(5),test_board.get_numbers_in_box(5))
p test_board.non_corresponding_nums(test_board.all_corresponding_nums(test_board.get_numbers_in_row(1), test_board.get_numbers_in_column(1), test_board.get_numbers_in_box(1)))
test_board.solve