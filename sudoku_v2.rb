class Sudoku
  def initialize(board_string)
    @board_string = board_string.split("").map { |e| e.to_i }
    @print_board = board_string
  end

  def get_row(empty_cell_or_number_index)
    @get_row = empty_cell_or_number_index / 9
  end

  def get_column(empty_cell_or_number_index)
    @get_column = empty_cell_or_number_index % 9
  end

  def get_box(empty_cell_or_number_index)
    @get_box = (get_column(empty_cell_or_number_index) / 3 + get_row(empty_cell_or_number_index) / 3) * 3
  end

  def find_probable_numbers(empty_cell_index)
    probable_answers = Array.new
    @board_string.each_with_index do |numbers_element,numbers_index|
      if numbers_element != 0
        if get_row(numbers_index) == get_row(empty_cell_index)
          probable_answers << numbers_element
        end
        if get_column(numbers_index) == get_column(empty_cell_index)
          probable_answers << numbers_element
        end
        if get_box(numbers_index) == get_box(empty_cell_index)
          probable_answers << numbers_element
        end
      end
    end
    range = *(1..9)
    probable_answers = probable_answers.uniq
    return probable_answers = range - probable_answers
  end

  def solved?
    if !@board_string.include?(0)
      return true
    end
      return false
  end

  def solve
    if @board_string.include?(0)
      @board_string.map.with_index do |empty_cell, empty_cell_index|
        if empty_cell == 0
          potential_numbers = find_probable_numbers(empty_cell_index)
          if potential_numbers.length == 1
            @board_string[empty_cell_index] = potential_numbers[0]
          else
            @board_string[empty_cell_index] = 0
          end
        else
          @board_string[empty_cell_index] = empty_cell
        end
      end
    end

    @board_string
  end

  # def solved?
  #   until !@board_string.include?(0)
  #     solve(@board_string)
  #   end
  # end

  def board
    "\n"
    @board_string.each_slice(9) { |rows| p rows}
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
  end
end

game = Sudoku.new("---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---")

puts game.board
#puts x = game.find_empty_cell_index
#p game.find_probable_numbers
game.solve
#p game.solve_cell(1)
game.board

#PSEUDOCODE
#Reverse
#Solve : First loop through the array, if the element == 0 find all the find_probable_numbers that can solve the find all the probable numbers that can solve the problem and put them into an array
# If the probable answers array has a length of 1 then assign that value to the index of the element with 0 value