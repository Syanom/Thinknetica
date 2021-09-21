require_relative 'menu.rb'

class MainMenu < Menu
  def initialize
    @object = "main"
    @content = [
      "Type s to go to station menu",
      "Type t to go to train menu",
      "Type r to go to route menu",
      "Type e to close program"
    ]
    super
  end

  def get_command
    command_shortcut = gets.chomp.to_sym
    case command_shortcut
    when :s
      @command = :station
    when :t
      @command = :train
    when :r
      @command = :route
    when :e
      @command = :exit
    else
      @command = :wrong
    end
  end
end
