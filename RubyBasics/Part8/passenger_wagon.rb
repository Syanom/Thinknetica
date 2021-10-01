require_relative 'wagon'

# Wagon for PassengerTrain class
class PassengerWagon < Wagon
  def initialize(id, seats)
    super('passenger', id, seats)
  end

  def take_seat
    raise 'No seats left' if space_left?.zero?

    @taken_space += 1
  end
end
