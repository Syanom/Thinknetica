require_relative 'train'
require_relative 'passenger_wagon'

# For operating passenger trains
class PassengerTrain < Train
  def initialize(name)
    super(name, 'passenger')
  end
end
