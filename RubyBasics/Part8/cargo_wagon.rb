require_relative 'wagon'

# Wagon for CargoTrain class
class CargoWagon < Wagon
  def initialize(id, volume)
    super('cargo', id, volume)
  end

  def take_volume(volume)
    raise "Available volume: #{space_left?} < loading volume: #{volume}. Operation cancelled" if space_left? < volume

    @taken_space += volume
  end
end
