require_relative 'object_menu.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'

class TrainMenu < ObjectMenu
  def initialize
    @object = "train"
    @content = [
      "Type a to add wagon",
      "Type r to remove wagon",
      "Type t to take route",
      "Type fw to move forward on route",
      "Type bw to move backward on route",
      "Type b to return back to main menu"
    ]
    super
  end

  def get_object(trains)
    if super(trains) == :y
      print "Enter trains's type: "
      type = gets.chomp.to_sym
      case type
      when :passenger
        trains << PassengerTrain.new(@current_object, type)
      when :cargo
        trains << CargoTrain.new(@current_object, type)
      else
        puts "We not support such type of trains yet."
      end
    end
    train = trains.find { |train| train.number == @current_object }
    @current_object = nil
    train
  end

  def get_command
    command_shortcut = gets.chomp.to_sym
    case command_shortcut
    when :a
      command = :add_wagon
    when :r
      command = :remove_wagon
    when :t
      command = :take_route
    when :fw
      command = :forward
    when :bw
      command = :backward
    when :b
      command = :back
    end

  end

end
