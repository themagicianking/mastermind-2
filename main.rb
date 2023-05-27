module GeneratePuzzle
  def puzzle_maker
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
    puzzle
  end
end

class Game
  include GeneratePuzzle
  attr_reader :guess, :hint, :puzzle

  def initialize
    @guess = []
    @hint = {1 => "-", 2 => "-", 3 => "-", 4 => "-"}
    @puzzle = puzzle_maker
    puts "Hello! Welcome to mastermind."
    puts "I will generate a puzzle for you to solve."
    puts "The puzzle will be four colors: R (red), Y (yellow), G (green), or B (blue)."
    puts "Any of these may be repeated."
    puts "Enter your guess and I will tell you if you got it right!"
    puts "X means right color right place. O means right color wrong place. - means the color is not in the puzzle."
  end

  def get_guess
    puts "Please enter your first guess:"
    choice = gets.chomp.upcase
    @guess.push(choice)
    puts "Please enter your second guess:"
    choice = gets.chomp.upcase
    @guess.push(choice)
    puts "Please enter your third guess:"
    choice = gets.chomp.upcase
    @guess.push(choice)
    puts "Please enter your last guess:"
    choice = gets.chomp.upcase
    @guess.push(choice)
  end

  def check_win(hint)
    hint == {1 => "X", 2 => "X", 3 => "X", 4 => "X"} ? true : false
  end

  def new_turn
    @guess = []
    @hint = {1 => "-", 2 => "-", 3 => "-", 4 => "-"}
  end

  def give_hints(guess, hint, puzzle)
    guess.each_with_index do |color, index|
      if color == puzzle[index]
        hint[index + 1] = "X"
      elsif puzzle.include? color
        hint[index + 1] = "O"
      else
      end
    end
    pp hint.values
  end
end

def play_again?
  puts "Would you like to play? Y or N. Invalid input will terminate game."
  gets.chomp.upcase == "Y" ? true : false
end

def play_game
  while play_again? == true
    new_game = Game.new
    while new_game.check_win(new_game.hint) == false
      new_game.new_turn
      new_game.get_guess
      new_game.hint
      new_game.check_win(new_game.hint)
      new_game.give_hints(new_game.guess, new_game.hint, new_game.puzzle)
    end
    puts "You guessed it! Good job!"
  end
end

play_game