require_relative 'object_menu.rb'
require_relative 'route.rb'

class RouteMenu < ObjectMenu
  def initialize
    @object = "route"
    @content = [
      "Type a to add station to route",
      "Type r to remove station from route",
      "Type app to appoint route to train",
      "Type b to return back to main menu"
    ]
    super
  end

  def get_object(routes, stations, station_menu)
    if super(routes) == :y
      puts "We need departure station"
      departure = station_menu.get_object(stations)
      return nil if departure == nil
      puts "We also need arrival station"
      arrival = station_menu.get_object(stations)
      return nil if departure == nil
      routes <<  Route.new(@current_object, departure, arrival)
    end
    route = routes.find { |route| route.name == @current_object }
    @current_object = nil
    route
  end

  def get_command
    command_shortcut = gets.chomp.to_sym
    case command_shortcut
    when :a
      command = :add
    when :r
      command = :remove
    when :app
      command = :appoint
    end
  end

  def add_station(route)

  end
end
