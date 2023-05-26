def generate_puzzle
  puzzle = []
  color = "none"
  for i in 1..4
    x = rand(4)
    if x == 1
      color = "R"
    elsif x == 2
      color = "Y"
    elsif x == 3
      color = "G"
    else
      color = "B"
    end
    puzzle.push(color)
  end
end

def start_game
  guess = []
  puts "Hello! Welcome to mastermind."
  puts "I will generate a puzzle for you to solve."
  puts "The puzzle will be four colors: R (red), Y (yellow), G (green), or B (blue)."
  puts "Any of these may be repeated."
  puts "Enter your guess and I will tell you if you got it right!"
  puts "X means right color right place. O means right color wrong place. - means the color is not in the puzzle."
  puts "Please enter your first guess:"
  guess.push(gets.chomp)
  pp guess
end

start_game