require_relative 'train.rb'
require_relative 'cargo_wagon.rb'

class CargoTrain < Train
  def initialize(number)
    super(number, "cargo")
  end

  def add_wagon
    super(CargoWagon.new)
  end
end
