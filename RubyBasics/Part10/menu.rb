# frozen_string_literal: true

# class for drawing menu and getting commmand
class Menu
  COMMANDS = { all: 'all_stations', st: 'trains_on_station', s: 'create_station', t: 'create_train', r: 'create_route',
               ra: 'add_station', rr: 'remove_station', a: 'take_route', wa: 'add_wagon', wr: 'remove_wagon',
               f: 'forward', b: 'backward', e: 'exit', wt: 'wagon_take', wl: 'wagons_list' }.freeze

  CONTENT = [
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
  ].freeze

  def initialize
    @top_border = '╔════════════════════════════════════════════╗'
    @bot_border = '╚════════════════════════════════════════════╝'
    @left_indent = '   '
  end

  def draw
    puts @top_border
    CONTENT.each { |string| puts @left_indent + string }
    puts @bot_border
  end

  def command
    shortcut = gets.chomp.to_sym
    COMMANDS[shortcut] || 'wrong'
  end
end
