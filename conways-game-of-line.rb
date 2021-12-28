def conways_game_of_line(seed, generations)
end

_ = :dead_cell
x = :alive_cell


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
