require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
@@guesses_remaining = 6

get '/' do
  @@guesses_remaining -= 1
  @guess = params["guess"]
  @cheat = params["cheat"]
  if params["Play Again?"] == "Play Again?"
    SECRET_NUMBER = rand(100)
    @@guesses_remaining = 5
    @guess = nil
  end
  message = check_guess
  bgcolor = check_color
  cheat_message = check_cheat
  if @@guesses_remaining == 0 || guess == SECRET_NUMBER
    erb :game_over, :locals => {
                            :secret_number => SECRET_NUMBER,
                            :guess => guess,
                            :message => message,
                            :bgcolor => bgcolor,
                            :guesses_remaining => @@guesses_remaining
                           }
  else
    erb :index, :locals => {
                            :secret_number => SECRET_NUMBER,
                            :guess => guess,
                            :message => message,
                            :bgcolor => bgcolor,
                            :guesses_remaining => @@guesses_remaining,
                            :cheat_message => cheat_message
                           }
                          #  throw params.inspect
  end
end

def check_guess
  message = "#{guess} is only a little too high!" if (1..5) === (guess - SECRET_NUMBER)
  message = "#{guess} is too high!" if (6..15) === (guess - SECRET_NUMBER)
  message = "#{guess} is WAY TOO HIGH!" if (guess - SECRET_NUMBER) > 15
  message = "#{guess} is only a bit too low!" if (1..5) === (SECRET_NUMBER - guess)
  message = "#{guess} is too low!" if (6..15) === (SECRET_NUMBER - guess)
  message = "#{guess} is WAY TOO LOW!" if (SECRET_NUMBER - guess) > 15
  message = "#{guess} is not between 0 and 100." if (guess < 0 || guess > 100)
  message = "That's not a number!" if not_a_valid_number
  message = "What could it be?" if number_string == nil
  message = "Too bad. The correct number was #{SECRET_NUMBER}." if @@guesses_remaining == 0
  message = "#{guess} is the SECRET NUMBER! You got it right!" if guess == SECRET_NUMBER
  message
end

def check_color
  color = :lightblue if guess == SECRET_NUMBER
  color = :lightgreen if (1..5) === difference
  color = :lightyellow if (6..15) === difference
  color = :pink if difference > 15
  color = :red if (guess > 100 || guess < 0) || not_a_valid_number
  color = :white if number_string == nil
  color
end

def check_cheat
  if @cheat
    "***CHEAT MODE ACTIVATED***</p> <p>The secret number is #{SECRET_NUMBER}"
  else
    "Good luck and have fun!"
  end
end

def difference
  (guess - SECRET_NUMBER).abs
end

def not_a_valid_number
  number_string.chars.any? {|char| (":".."z") === char} unless number_string == nil
end

def number_string
  @guess
end

def guess
  @guess.to_i
end
