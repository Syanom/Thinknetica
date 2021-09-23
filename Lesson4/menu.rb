class Menu
  def initialize
    @menu_width = 40
    @top_border = "╔══════════════════════════════════════╗"
    @bot_border = "╚══════════════════════════════════════╝"
    @left_indent = "   "
    @title = @object.upcase + " menu"
  end

  def draw
    puts @top_border
    puts @title.center(@menu_width, ' ')
    puts ""
    @content.each { |string| puts @left_indent + string }
    puts @bot_border
  end

  def get_command
  end

  protected
  # Все это нужно для функции отрисовки меню. Другим частям программы этого знать не обязательно
  attr_reader :command
  attr_reader :object
  attr_reader :title
  attr_reader :content
end
