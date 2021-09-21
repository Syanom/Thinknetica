require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'main_menu.rb'
require_relative 'station_menu.rb'

main_menu = MainMenu.new
station_menu = StationMenu.new
# route_menu = RouteMenu.new
stations = []
routes = []

loop do
  main_menu.draw
  case main_menu.get_command
  when :station
    station = station_menu.get_station(stations)
    next if station == nil
    station_menu.draw
    case station_menu.get_command
    when :trains
      unless station.trains.empty?
        puts station.trains
      else
        puts "There're no trains on this station"
      end
    when :back
      next
    end

  when :route
    puts "Route menu under construction"
    # name = route_menu.get_route(routes)
    # route_menu.draw
    # case route_menu.get_command
    # when :add

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
