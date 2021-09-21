require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'main_menu.rb'
require_relative 'station_menu.rb'
require_relative 'route_menu.rb'
require_relative 'train_menu.rb'

main_menu = MainMenu.new
station_menu = StationMenu.new
route_menu = RouteMenu.new
train_menu = TrainMenu.new
stations = []
routes = []
trains = []

loop do
  main_menu.draw
  case main_menu.get_command
  when :station
    station = station_menu.get_object(stations)
    next if station == nil
    station_menu.draw
    case station_menu.get_command
    when :trains
      unless station.trains.empty?
        station.trains.each { |train| puts "#{train.type.to_s.capitalize} train: #{train.number.to_s}" }
      else
        puts "There're no trains on this station"
      end
    when :back
      next
    end

  when :route
    route = route_menu.get_object(routes, stations, station_menu)
    next if route == nil
    route_menu.draw
    case route_menu.get_command
    when :add
      station = station_menu.get_object(stations)
      next if station == nil
      route.add_station(station)
    when :remove
      station = station_menu.get_object(stations)
      next if station == nil
      route.remove_station(station)
    when :appoint
      train = train_menu.get_object(trains)
      next if train == nil
      train.take_route(route)
    end

  when :train
    puts "Train menu under construction"

  when :exit
    break
  else
    puts "Wrong command"
  end
  puts "Press enter to continue"
  gets
end
