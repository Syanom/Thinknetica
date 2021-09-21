require_relative 'menu.rb'

class TrainMenu < Menu
  def initialize
    @object = "Train"
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

  def get_train(trains)
    print "Enter train name: "
    name = gets.chomp.to_sym
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
