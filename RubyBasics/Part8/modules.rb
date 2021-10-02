# Module to set and get wagon's and train's manufacturers
module Manufacturer
  protected

  attr_accessor :manufacturer
end

# Module for counting instances
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Creating and increasing class variable for counting instances
  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def increase_instances
      @@instances += 1
    end
  end

  # Module for increasing instances variable
  module InstanceMethods
    protected

    def register_instance
      self.class.increase_instances
    end
  end
end
