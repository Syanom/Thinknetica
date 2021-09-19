require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

loop do
  puts "┌--------------------------------------------┐"
  puts "  Type one of this commands:"
  puts ""
  puts "  Station commands:"
  puts "  CreateStation to create station"
  puts "  StationInfo to view all trains on station"
  puts "  StationsList to view existed stations"
  puts ""
  puts "  Route commands:"
  puts "  CreateRoute to create route"
  puts "  AddRoute to add station to route"
  puts "  RemoveRoute to remove station from route"
  puts "  AsignRoute to assign route for train"
  puts ""
  puts "  Train commands:"
  puts "  CreateTrain to create train"
  puts "  AddWagon to add wagon to the train"
  puts "  RemoveWagon to remove wagon from the train"
  puts "  Forward to move train forward"
  puts "  Backward to move train backward"
  puts ""
  puts "  Exit to close the program"
  puts "└--------------------------------------------┘"
  command = gets.chomp.to_sym

  case command
  when :CreateStation

  when :StationInfo

  when :StationsList

  when :CreateRoute

  when :AddRoute

  when :RemoveRoute

  when :AssignRoute

  when :CreateTrain

  when :AddWagon

  when :RemoveWagon

  when :Forward

  when :Backward

  when :Exit
    break
  else
    puts "Wrong command"
  end
end
