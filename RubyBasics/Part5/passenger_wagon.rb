require_relative 'wagon.rb'

class PassengerWagon < Wagon
  def initialize
    super("passenger")
  end
end
