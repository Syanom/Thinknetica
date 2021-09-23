require_relative 'wagon.rb'

class CargoWagon < Wagon
  def initialize
    super("cargo")
  end
end
