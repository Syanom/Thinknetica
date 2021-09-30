require_relative 'wagon.rb'

class PassengerWagon < Wagon
  attr_reader :seats
  attr_reader :taken_seats

  def initialize(seats)
    @seats = seats
    @taken_seats = 0
    super("passenger")
  end

  def take_seat
    @taken_seats += 1
  end

  def seats_left?
    @seats - @taken_seats
  end
end
