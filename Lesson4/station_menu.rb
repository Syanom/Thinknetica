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

  def get_object(stations)
    stations << Station.new(@current_object) if super(stations) == :y
    stations.find { |station| station.name == @current_object }
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
end
