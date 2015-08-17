require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)

get '/' do
  guess = params["guess"].to_i
  message = "the SECRET NUMBER! You got it right!" if guess == secret_number
  message = "only a little too high!" if (1..5) === (guess - secret_number)
  message = "too high!" if (6..15) === (guess - secret_number)
  message = "WAY TOO HIGH!" if (guess - secret_number) > 15
  message = "only a bit too low!" if (1..5) === (secret_number - guess)
  message = "too low!" if (6..15) === (secret_number - guess)
  message = "WAY TOO LOW!" if (secret_number - guess) > 15

  erb :index, :locals => {:secret_number => secret_number, :guess => guess, :message => message}
end
