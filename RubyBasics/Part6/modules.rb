module Manufacturer
  def set_manufacturer(manufacturer)
    self.manufacturer = manufacturer
  end

  def get_manufacturer
    self.manufacturer
  end

  protected
  attr_accessor :manufacturer
end


module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def increase_instances
      @@instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.increase_instances
    end
  end
end
