require_relative 'menu.rb'

class ObjectMenu < Menu
  def get_object(objects)
    print "Enter #{@object} name: "
    name = gets.chomp.to_sym
    unless objects.any? { |object| object.name == name }
      print "No such #{@object} found. Want to create new? y/n: "
      command = gets.chomp.to_sym

      # вот это место
      command == :y ? objects << Station.new(name) : stations
      subclass.test
    end
    objects.find { |object| object.name == name }
  end
end
