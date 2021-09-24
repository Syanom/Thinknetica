require_relative 'train.rb'
require_relative 'passenger_wagon.rb'

class PassengerTrain < Train
  def initialize(name)
    super(name, "passenger")
  end

  def add_wagon
    super(PassengerWagon.new)
  end
end
