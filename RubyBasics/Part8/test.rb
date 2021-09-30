require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'menu.rb'

a = Station.new("a")
b = Station.new("b")
route = Route.new("ab", a, b)
t1 = PassengerTrain.new("12345")
t2 = CargoTrain.new("54321")
t1.take_route(route)
t2.take_route(route)

b.each_train { |train| puts train.number }
