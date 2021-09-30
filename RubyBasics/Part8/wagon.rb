require_relative 'modules.rb'

class Wagon
  include Manufacturer

  attr_reader :type
  attr_reader :id

  alias_method :name, :id

  def initialize(type, id)
    @type = type
    @id = id
  end
end
