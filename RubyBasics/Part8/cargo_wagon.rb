require_relative 'wagon.rb'

class CargoWagon < Wagon
  attr_reader :volume
  attr_reader :taken_volume

  def initialize(id, volume)
    @volume = volume
    @taken_volume = 0
    super("cargo", id)
  end

  def take_volume(volume)
    @taken_volume += volume
  end

  def volume_left?
    @volume - @taken_volume
  end
end
