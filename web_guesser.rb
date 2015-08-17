require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)

get '/' do
  guess = params["guess"]
  if guess.to_i > secret_number
    message = "Too High!"
  else
    message = "Too Low!"
  end

  erb :index, :locals => {:secret_number => secret_number, :guess => guess, :message => message}
end
