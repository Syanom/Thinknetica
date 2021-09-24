require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'menu.rb'

menu = Menu.new
stations = []
routes = []
trains = []

loop do
  menu.draw
  case menu.get_command
  when "all_stations"
    stations.each { |station| puts station.name }
  when "trains_on_station"
    station = menu.find_object("station", stations)
    next if station == nil
    station.trains.each { |train| puts "#{train.type.capitalize} train #{train.name}" }
  when "create_station"
    print "Enter station's name: "
    name = gets.chomp
    stations << Station.new(name)
    puts "Station #{name} created"
  when "create_train"
    print "Enter train's number: "
    number = gets.chomp
    print "Enter train's type: "
    type = gets.chomp
    case type
    when "passenger"
      trains << PassengerTrain.new(number)
      puts "Passenger train #{number} created"
    when "cargo"
      trains << CargoTrain.new(number)
      puts "Cargo train #{number} created"
    else
      puts "Wrong train type"
    end
  when "create_route"
    departure = menu.find_object("departure station", stations)
    next if departure == nil
    arrival = menu.find_object("arival station", stations)
    next if arrival == nil
    print "Enter route's name: "
    name = gets.chomp
    routes << Route.new(name, departure, arrival)
    puts "Route #{name} created"
  when "add_station"
    route = menu.find_object("route", routes)
    next if route == nil
    station = menu.find_object("station", stations)
    next if station == nil
    puts route.add_station(station)
  when "remove_station"
    route = menu.find_object("route", routes)
    next if route == nil
    station = menu.find_object("station", stations)
    next if station == nil
    puts route.remove_station(station)
  when "take_route"
    train = menu.find_object("train", trains)
    next if train == nil
    route = menu.find_object("route", routes)
    next if route == nil
    puts train.take_route(route)
  when "add_wagon"
    train = menu.find_object("train", trains)
    next if train == nil
    puts train.add_wagon
  when "remove_wagon"
    train = menu.find_object("train", trains)
    next if train == nil
    puts train.remove_wagon
  when "forward"
    train = menu.find_object("train", trains)
    next if train == nil
    puts train.move_forward
  when "backward"
    train = menu.find_object("train", trains)
    next if train == nil
    puts train.move_backward
  when "exit"
    break
  else
    puts "Wrong command"
  end
end
