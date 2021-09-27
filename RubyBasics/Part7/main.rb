require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'menu.rb'

class Main
  def initialize
    @menu = Menu.new
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    loop do
      @menu.draw
      case @menu.get_command
      when "all_stations"
        @stations.each { |station| puts station.name }
      when "trains_on_station"
        trains_on_station
      when "create_station"
        create_station
      when "create_train"
        create_train
      when "create_route"
        create_route
      when "add_station"
        add_station
      when "remove_station"
        remove_station
      when "take_route"
        take_route
      when "add_wagon"
        add_wagon
      when "remove_wagon"
        remove_wagon
      when "forward"
        forward
      when "backward"
        backward
      when "exit"
        break
      else
        puts "Wrong command"
      end
    end
  end

  protected

  def trains_on_station
    station = find_object("station", @stations)
    puts "There are no trains on this station" if station.trains.empty?
    station.trains.each { |train| puts "#{train.type.capitalize} train #{train.number}" }
  rescue RuntimeError => e
    puts e.message
  end

  def create_station
    print "Enter station's name: "
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station #{name} created"
  end

  def create_train
    begin
      print "Enter train's number: "
      number = gets.chomp
      print "Enter train's type: "
      type = gets.chomp
      Train.new(number, type)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    case type
    when "passenger"
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} created"
    when "cargo"
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} created"
    end
  end

  def create_route
    departure = find_object("departure station", @stations)
    arrival = find_object("arival station", @stations)
    print "Enter route's name: "
    name = gets.chomp
    @routes << Route.new(name, departure, arrival)
    puts "Route #{name} created"
  rescue RuntimeError => e
    puts e.message
  end

  def add_station
    route = find_object("route", @routes)
    station = find_object("station", @stations)
    route.add_station(station)
    puts "Station #{station.name} has been added to route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_station
    route = find_object("route", @routes)
    station = find_object("station", @stations)
    route.remove_station(station)
    puts "Station #{station.name} has been removed from route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def take_route
    train = find_object("train", @trains)
    route = find_object("route", @routes)
    train.take_route(route)
    "The #{train.type} train #{train.number} has taken the route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_wagon
    train = find_object("train", @trains)
    puts train.add_wagon
  rescue RuntimeError => e
    puts e.message
  end

  def remove_wagon
    train = find_object("train", @trains)
    puts train.remove_wagon
  rescue RuntimeError => e
    puts e.message
  end

  def forward
    train = find_object("train", @trains)
    puts train.move_forward
  rescue RuntimeError => e
    puts e.message
  end

  def backward
    train = find_object("train", @trains)
    puts train.move_backward
  rescue RuntimeError => e
    puts e.message
  end

  def find_object(object_type, objects)
    print "Enter #{object_type}'s name: "
    name = gets.chomp
    object = objects.find { |object| object.name == name }
    raise "#{object_type.capitalize} #{name} is not exist" if object == nil
    object
  end
end

Main.new.run
