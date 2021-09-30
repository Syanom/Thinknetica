require_relative 'wagon.rb'

class PassengerWagon < Wagon
  attr_reader :seats
  attr_reader :taken_seats

  def initialize(id, seats)
    @seats = seats
    @taken_seats = 0
    super("passenger", id)
  end

  def take_seat
    raise "No sits left" if seats_left? == 0
    @taken_seats += 1
  end

  def seats_left?
    @seats - @taken_seats
  end
end
