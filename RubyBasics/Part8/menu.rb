# class for drawing menu and getting commmand
class Menu
  def initialize
    @top_border = '╔════════════════════════════════════════════╗'
    @bot_border = '╚════════════════════════════════════════════╝'
    @left_indent = '   '
    @content = [
      'Type all to watch list of all stations',
      'Type st to watch trains on station',
      'Type s to create station',
      'Type t to create train',
      'Type r to create route',
      'Type ra to add station into route',
      'Type rr to remove station from route',
      'Type a to appoint route to train',
      'Type wa to add wagon to train',
      'Type wr to remove wagon from train',
      'Type wt to take volume/seats in wagon',
      'Type wl to watch all wagons on train',
      'Type f to move train forward on route',
      'Type b to move train backward from route',
      'Type e to exit the program'
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
    when 'all'
      'all_stations'
    when 'st'
      'trains_on_station'
    when 's'
      'create_station'
    when 't'
      'create_train'
    when 'r'
      'create_route'
    when 'ra'
      'add_station'
    when 'rr'
      'remove_station'
    when 'a'
      'take_route'
    when 'wa'
      'add_wagon'
    when 'wr'
      'remove_wagon'
    when 'f'
      'forward'
    when 'b'
      'backward'
    when 'e'
      'exit'
    when 'wt'
      'wagon_take'
    when 'wl'
      'wagons_list'
    else
      'wrong'
    end
  end
end
