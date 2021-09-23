require_relative 'menu.rb'

class ObjectMenu < Menu
  def initialize
    @current_object = nil
    super
  end

  def get_object(objects)
    print "Enter #{@object} name: "
    @current_object = gets.chomp.to_s.to_s
    unless objects.any? { |object| object.name == @current_object }
      print "No such #{@object} found. Want to create new? y/n: "
      command = gets.chomp.to_s
    end
  end
end
