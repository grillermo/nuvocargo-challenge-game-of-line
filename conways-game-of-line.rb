# -*- encoding : utf-8 -*-
class Array
  def tally_by(&function)
    function ||= -> v { v }

    each_with_object(Hash.new(0)) do |value, hash|
      hash[function.call(value)] += 1
    end
  end

  def tally
    tally_by(&:itself)
  end
end

class LifeSimulator
  def initialize(seed)
    @seed = seed
  end

  def cell_status(height, position, row_index, column_index)
    case height
    when :top
      row_index -= 1
    when :bottom
      row_index += 1
    end

    case position
    when :left
      column_index -= 1
    when :right
      column_index += 1
    end
      
    # Out of the bounds of our universe
    if row_index < 0 || (row_index + 1 > @seed.length)
      return :dead
    end

    # Out of the bounds of our universe
    if column_index < 0 || (column_index + 1 > @seed.length)
      return :dead
    end

    @seed[row_index][column_index]
  end

  def get_neighbours(cell, row_index, column_index)
    statuses = []

    [
      [:top,    :left], [:top,    :center], [:top, :right],
      [:middle, :left],                     [:middle, :right],
      [:bottom, :left], [:bottom, :center], [:bottom, :right],
    ].each do |height, position|
      statuses << cell_status(height, position, row_index, column_index)
    end

    statuses.tally
  end

  # Rule 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  # Rule 2. Any live cell with two or three live neighbours lives on to the next generation.
  # Rule 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
  # Rule 4. 4ny dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  def next_generation
    # If only we had ActiveSupport deep_dup we wouldnt need to do this
    @next_universe = Marshal.load(Marshal.dump(@seed))

    @seed.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        neighbours = get_neighbours(cell, row_index, column_index)  

        alive_neighbours = neighbours[:alive] || 0

        if cell == :alive
          if alive_neighbours < 2
            # Rule 1
             cell = :dead
          elsif alive_neighbours == 2 || alive_neighbours == 3
            # Rule 2
            cell = :alive
          elsif alive_neighbours > 3
            # Rule 3
            cell = :dead
          end
        else
          # Rule 4
          if alive_neighbours == 3
            cell = :alive
          end
        end

        @next_universe[row_index][column_index] = cell
      end
    end

    @next_universe
  end
end

def conways_game_of_life(seed)
  simulator = LifeSimulator.new(seed)

  simulator.next_generation
end

_ = :dead
x = :alive

# Try with some wikipedia examples
BLINKER = [
    [_,_,_,_,_],
    [_,_,x,_,_],
    [_,_,x,_,_],
    [_,_,x,_,_],
    [_,_,_,_,_],
]
NEXT_GENERATION_BLINKER = [
    [_,_,_,_,_],
    [_,_,_,_,_],
    [_,x,x,x,_],
    [_,_,_,_,_],
    [_,_,_,_,_],
]

TOAD = [
  [_,_,_,_,_,_],
  [_,_,_,_,_,_],
  [_,_,x,x,x,_],
  [_,x,x,x,_,_],
  [_,_,_,_,_,_],
  [_,_,_,_,_,_],
]

NEXT_GENERATION_TOAD = [
  [_,_,_,_,_,_],
  [_,_,_,x,_,_],
  [_,x,_,_,x,_],
  [_,x,_,_,x,_],
  [_,_,x,_,_,_],
  [_,_,_,_,_,_],
]

def test(function_name)
  examples = [
    {
      input: BLINKER,
      expected: NEXT_GENERATION_BLINKER,
    },
    {
      input: NEXT_GENERATION_BLINKER,
      expected: BLINKER,
    },
    {
      input: TOAD,
      expected: NEXT_GENERATION_TOAD,
    },
  ]

  examples.each do |example|
    input    = example[:input]
    puts "\nTrying new input:"
    pp input
    expected = example[:expected]
    result   = conways_game_of_life(input)
    valid    = result == expected

    if valid
      puts "SUCCESS"
      puts "was the expected"
      pp expected
    else
      puts "FAIL"
      puts "is expected to be #{expected} "
      pp expected
      puts "but it was "
      pp result
    end
  end
end

$debug = false
test :conways_game_of_life
