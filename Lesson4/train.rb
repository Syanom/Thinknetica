class Train
  attr_accessor :speed
  attr_reader :number_of_wagons
  attr_reader :type

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @speed == 0 ? @number_of_wagons += 1 : "First stop the train!"
  end

  def remove_wagon
    @speed == 0 && number_of_wagons != 0 ? @number_of_wagons -= 1 : "First stop the train / Make sure that train has at least one wagon"
  end

  def move_forward
    unless @current_position == @route.length - 1
      @route[@current_position].train_departure(self)
      @current_position += 1
      @route[@current_position].train_arrive(self)
    else
      "The train is at the last stop on the route, no way forward!"
    end
  end

  def move_backward
    unless @current_position == 0
      @route[@current_position].train_departure(self)
      @current_position -= 1
      @route[@current_position].train_arrive(self)
    else
      "The train is at the starting point of the route, no way backward!"
    end
  end

  def take_route(route)
    @route = route
    if @route[0].list_of_trains.include?(self)
      @current_position = 0
      move_forward
    else
      "The train isn't on the starting point of the route!"
    end
  end

  def current_station
    @route[@current_position]
  end

  def next_station
    @current_position != @route.length - 1 ? @route[@current_position + 1] : "Train is at last point of the route"
  end

  def previous_station
    @current_position != 0 ? @route[@current_position - 1] : "Train is at first station in the route"
  end
end
