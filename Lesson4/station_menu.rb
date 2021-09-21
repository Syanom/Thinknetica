require_relative 'object_menu.rb'
require_relative 'station.rb'

class StationMenu < ObjectMenu
  def initialize
    @object = "station"
    @content = [
      "Type t to print all trains on station",
      "Type b to return back to main menu"
    ]
    super
  end

  def get_station(stations)
    print "Enter station name: "
    name = gets.chomp.to_sym
    unless stations.any? { |station| station.name == name }
      print "No such station found. Want to create new? y/n: "
      command = gets.chomp.to_sym
      command == :y ? stations << Station.new(name) : stations
    end
    stations.find { |station| station.name == name }
  end

  def get_command
    command_shortcut = gets.chomp.to_sym
    case command_shortcut
    when :t
      @command = :trains
    when :b
      @command = :back
    else
      @command = :wrong
    end
  end

  def test
    puts "Calling subclass method works!"
  end
end
