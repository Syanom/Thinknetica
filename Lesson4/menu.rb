class Menu
  def initialize
    @top_border = "╔════════════════════════════════════════════╗"
    @bot_border = "╚════════════════════════════════════════════╝"
    @left_indent = "   "
    @content = [
      "Type all to watch list of all stations",
      "Type st to watch trains on station",
      "Type s to create station",
      "Type t to create train",
      "Type r to create route",
      "Type ra to add station into route",
      "Type rr to remove station from route",
      "Type a to appoint route to train",
      "Type wa to add wagon to train",
      "Type wr to remove wagon from train",
      "Type f to move train forward on route",
      "Type b to move train backward from route",
      "Type e to exit the program"
    ]
  end

  def draw
    puts @top_border
    @content.each { |string| puts @left_indent + string }
    puts @bot_border
  end

  def get_command
    shortcut = gets.chomp
    case shortcut
    when "all"
      command = "all_stations"
    when "st"
      command = "trains_on_station"
    when "s"
      command = "create_station"
    when "t"
      command = "create_train"
    when "r"
      command = "create_route"
    when "ra"
      command = "add_station"
    when "rr"
      command = "remove_station"
    when "a"
      command = "take_route"
    when "wa"
      command = "add_wagon"
    when "wr"
      command = "remove_wagon"
    when "f"
      command = "forward"
    when "b"
      command = "backward"
    when "e"
      command = "exit"
    else
      command = "wrong"
    end
  end
end
