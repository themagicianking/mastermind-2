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

  def guess_maker(hint, guess)
    new_guess = []
    guess.each_with_index do |color, index|
      if hint[index + 1] == "-"
        @possible_colors.delete(color)
      end
    end
    guess.each_with_index do |color, index|
      if hint[index + 1] == "-" || hint[index + 1] == "O"
        new_guess.push(@possible_colors.sample)
      else
        new_guess.push(color)
      end
    end
    new_guess
  end
end

class Game
  include GeneratePuzzle
  attr_reader :guess, :hint, :puzzle, :type, :continue, :possible_colors
  attr_writer :guess, :hint

  def initialize
    @guess = []
    @hint = {1 => "-", 2 => "-", 3 => "-", 4 => "-"}
    puts "Would you like to play? Y or N. Invalid input will terminate game."
    @continue = gets.chomp.upcase == "Y" ? true : false
    puts "Would you like to be the guesser or the puzzle master? Select G or P."
    @type = gets.chomp.upcase
    if @type == "G"
      @puzzle = puzzle_maker
    else
      @puzzle = []
      @possible_colors = ["R", "Y", "G", "B"]
    end
  end

  def start
    puts "Hello! Welcome to mastermind."
    if @type == "G"
      puts "I will generate a puzzle for you to solve."
      puts "The puzzle will be four colors: R (red), Y (yellow), G (green), or B (blue)."
      puts "Any of these may be repeated."
      puts "Enter your guess and I will tell you if you got it right!"
      puts "X means right color right place. O means right color wrong place. - means the color is not in the puzzle."
    else
      puts "Create a puzzle, and I will solve it."
      puts "The puzzle will be four colors: R (red), Y (yellow), G (green), or B (blue)."
      puts "Any of these may be repeated."
      puts "Enter your puzzle and I will try to guess what it is!"
      puts "After I guess, I will ask you to give me a hint."
      puts "X means right color right place. O means right color wrong place. - means the color is not in the puzzle."
    end
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

  def get_puzzle
    puts "Please enter your first color:"
    choice = gets.chomp.upcase
    @puzzle.push(choice)
    puts "Please enter your second color:"
    choice = gets.chomp.upcase
    @puzzle.push(choice)
    puts "Please enter your third color:"
    choice = gets.chomp.upcase
    @puzzle.push(choice)
    puts "Please enter your last color:"
    choice = gets.chomp.upcase
    @puzzle.push(choice)
  end

  def get_hint
    puts "How did I do? Please input X, O, or - for my first color:"
    @hint[1] = gets.chomp.upcase
    puts "Please input X, O, or - for my second color:"
    @hint[2] = gets.chomp.upcase
    puts "Please input X, O, or - for my third color:"
    @hint[3] = gets.chomp.upcase
    puts "Please input X, O, or - for my last color:"
    @hint[4] = gets.chomp.upcase
    @hint
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

  def play_again?
    puts "Would you like to play? Y or N. Invalid input will terminate game."
    @continue = gets.chomp.upcase == "Y" ? true : false
  end
end

new_game = Game.new
new_game.start
new_game.get_puzzle
puts "Here is my guess:"
pp new_game.guess = new_game.puzzle_maker
new_game.hint = new_game.get_hint
if new_game.check_win(new_game.hint)
  puts "I guessed it!"
else
  while new_game.check_win(new_game.hint) == false
    new_game.check_win(new_game.hint)
    new_game.guess = new_game.guess_maker(new_game.hint, new_game.guess)
    puts "Here is my guess:"
    pp new_game.guess
    new_game.hint = new_game.get_hint
  end
  puts "I guessed it!"
end

#while new_game.continue
  # new_game.start
  #if new_game.type == "G"
    #new_game.new_turn
    #new_game.get_guess
    #new_game.hint
    #new_game.check_win(new_game.hint)
    #new_game.give_hints(new_game.guess, new_game.hint, new_game.puzzle)
  #else
    # code for playing w the computer
  #end
  # new_game.play_again?
#end