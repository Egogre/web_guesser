require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  bgcolor = check_color(guess)

  erb :index, :locals => {
                          :secret_number => SECRET_NUMBER,
                          :guess => guess,
                          :message => message,
                          :bgcolor => bgcolor
                         }
end

def check_guess(number)
  guess = number.to_i
  message = "#{guess} is the SECRET NUMBER! You got it right!" if guess == SECRET_NUMBER
  message = "#{guess} is only a little too high!" if (1..5) === (guess - SECRET_NUMBER)
  message = "#{guess} is too high!" if (6..15) === (guess - SECRET_NUMBER)
  message = "#{guess} is WAY TOO HIGH!" if (guess - SECRET_NUMBER) > 15
  message = "#{guess} is only a bit too low!" if (1..5) === (SECRET_NUMBER - guess)
  message = "#{guess} is too low!" if (6..15) === (SECRET_NUMBER - guess)
  message = "#{guess} is WAY TOO LOW!" if (SECRET_NUMBER - guess) > 15
  message = "#{guess} is not between 0 and 100." if guess < 0
  message = "#{guess} is not between 0 and 100." if guess > 100
  message = "What could it be?" if number == nil
  message
end

def check_color(number)
  guess = number.to_i
  difference = (guess - SECRET_NUMBER).abs
  color = :lightblue if guess == SECRET_NUMBER
  color = :lightgreen if (1..5) === difference
  color = :lightyellow if (6..15) === difference
  color = :pink if difference > 15
  color = :red if (guess > 100 || guess < 0)
  color = :white if number == nil
  color
end
