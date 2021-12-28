def conways_game_of_line(seed, generations)
end

_ = :dead_cell
x = :alive_cell

BLINKER = [
    [_,_,_,_,_],
    [_,_,x,_,_],
    [_,_,x,_,_],
    [_,_,x,_,_],
    [_,_,_,_,_],
]

SECOND_GENERATION_BLINKER = [
    [_,_,_,_,_],
    [_,_,_,_,_],
    [_,x,x,x,_],
    [_,_,_,_,_],
    [_,_,_,_,_],
]
def test(function_name)
  $debug = true
  examples = [
    {
      input: [BLINKER, 1],
      expected: SECOND_GENERATION_BLINKER,
    },
  ]

  examples.each do |example|
    input    = example[:input]
    puts "\nTrying new input: #{input}"
    expected = example[:expected]
    result   = conways_game_of_line(*input)
    valid    = result == expected

    if valid
      puts "SUCCESS"
      puts "was the expected #{expected}"
    else
      puts "FAIL"
      puts "is expected to be #{expected} but it was #{result}"
    end
  end
end

test :conways_game_of_line
