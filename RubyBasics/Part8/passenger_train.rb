require_relative 'train.rb'
require_relative 'passenger_wagon.rb'

class PassengerTrain < Train
  def initialize(name)
    super(name, "passenger")
  end

  def add_wagon(seats)
    super(PassengerWagon.new(seats))
  end
end
