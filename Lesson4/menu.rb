class Menu
  attr_reader :command
  attr_reader :arguments
  attr_reader :content
  attr_reader :object

  attr_reader :title

  def initialize
    @menu_width = 40
    @top_border = "╔══════════════════════════════════════╗"
    @bot_border = "╚══════════════════════════════════════╝"
    @left_indent = "   "
    @title = @object.upcase + " menu"
  end

  def draw
    system "clear"
    puts @top_border
    puts @title.center(@menu_width, ' ')
    puts ""
    @content.each { |string| puts @left_indent + string }
    puts @bot_border
  end

  def get_command
  end
end
