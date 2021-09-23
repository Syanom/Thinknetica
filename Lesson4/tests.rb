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

stations << Station.new(:a)
stations << Station.new(:b)
stations << Station.new(:c)
trains << PassengerTrain.new(1.to_s.to_sym)
routes << Route.new(1.to_s.to_sym, stations.find { |station| station.name == :a }, stations.find { |station| station.name == :c })
