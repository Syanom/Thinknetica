require_relative 'train'
require_relative 'cargo_wagon'

# For operating cargo trains
class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end
end
