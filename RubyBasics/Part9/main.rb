# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'menu'

# Class for running the programm
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
      case @menu.command
      when 'all_stations'
        @stations.each { |station| puts station.name }
      when 'trains_on_station'
        trains_on_station
      when 'create_station'
        create_station
      when 'create_train'
        create_train
      when 'create_route'
        create_route
      when 'add_station'
        add_station
      when 'remove_station'
        remove_station
      when 'take_route'
        take_route
      when 'add_wagon'
        add_wagon
      when 'remove_wagon'
        remove_wagon
      when 'forward'
        forward
      when 'backward'
        backward
      when 'wagon_take'
        wagon_take
      when 'wagons_list'
        wagons_list
      when 'exit'
        break
      else
        puts 'Wrong command'
      end
    end
  end

  protected

  def trains_on_station
    station = find_object('station', @stations)
    puts "There're no trains on this station" if station.trains.empty?
    station.each_train { |train| puts "#{train.type.capitalize} train #{train.number}" }
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
    when 'passenger'
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} created"
    when 'cargo'
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} created"
    end
  end

  def create_route
    departure = find_object('departure station', @stations)
    arrival = find_object('arival station', @stations)
    print "Enter route's name: "
    name = gets.chomp
    @routes << Route.new(name, departure, arrival)
    puts "Route #{name} created"
  rescue RuntimeError => e
    puts e.message
  end

  def add_station
    route = find_object('route', @routes)
    station = find_object('station', @stations)
    route.add_station(station)
    puts "Station #{station.name} has been added to route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_station
    route = find_object('route', @routes)
    station = find_object('station', @stations)
    route.remove_station(station)
    puts "Station #{station.name} has been removed from route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def take_route
    train = find_object('train', @trains)
    route = find_object('route', @routes)
    train.take_route(route)
    puts "The #{train.type} train #{train.number} has taken the route #{route.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def forward
    train = find_object('train', @trains)
    train.move_forward
    puts "The #{train.type} train #{train.number} has moved to the #{train.current_station.name} station"
  rescue RuntimeError => e
    puts e.message
  end

  def backward
    train = find_object('train', @trains)
    train.move_backward
    puts "The #{train.type} train #{train.number} has moved to the #{train.current_station.name} station"
  rescue RuntimeError => e
    puts e.message
  end

  def add_wagon
    train = find_object('train', @trains)
    print "Enter wagon's id: "
    id = gets.chomp
    case train.type
    when 'cargo'
      print "Enter wagon's volume: "
      volume = gets.chomp.to_f
      train.add_wagon(CargoWagon.new(id, volume))
    when 'passenger'
      print "Enter wagon's amount of seats: "
      seats = gets.chomp.to_i
      train.add_wagon(PassengerWagon.new(id, seats))
    else
      raise 'We not support such type of train yet'
    end
    puts "Wagon #{id} has been added to #{train.type} train #{train.number}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_wagon
    train = find_object('train', @trains)
    wagon = find_object('wagon', train.wagons)
    train.remove_wagon(wagon)
    puts "Wagon #{wagon.id} removed from #{train.type} train #{train.number}"
  rescue RuntimeError => e
    puts e.message
  end

  def wagons_list
    train = find_object('train', @trains)
    case train.type
    when 'passenger'
      train.wagons.each do |wagon|
        puts "Wagon #{wagon.id}, free seats: #{wagon.space_left?}, taken seats: #{wagon.taken_space}"
      end
    when 'cargo'
      train.wagons.each do |wagon|
        puts "Wagon #{wagon.id}, free volume: #{wagon.space_left?}, taken volume: #{wagon.taken_space}"
      end
    end
  rescue RuntimeError => e
    puts e.message
  end

  def wagon_take
    train = find_object('train', @trains)
    wagon = find_object('wagon', train.wagons)
    case train.type
    when 'passenger'
      wagon.take_seat
      puts 'One seat has been taken'
    when 'cargo'
      print 'Enter amount of volume you want to take: '
      volume = gets.chomp.to_f
      wagon.take_volume(volume)
      puts "#{volume} has been loaded to wagon #{wagon.id}"
    end
  rescue RuntimeError => e
    puts e.message
  end

  def find_object(object_type, objects)
    print "Enter #{object_type}'s id: "
    name = gets.chomp
    object = objects.find { |object| object.name == name }
    raise "#{object_type.capitalize} #{name} is not exist" if object.nil?

    object
  end
end

Main.new.run
