# frozen_string_literal: true

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

# Metaprogramming custom accessors
module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError "Variable's name is not symbol" unless method.is_a?(Symbol)

      define_method(method) do
        instance_variable_get("@#{method}")
      end

      define_method("#{method}=") do |value|
        instance_variable_set("@#{method}", value)
        instance_variable_set("@#{method}_history", []) unless instance_variable_get("@#{method}_history")
        instance_variable_get("@#{method}_history").push(value)
      end

      define_method("#{method}_history") do
        instance_variable_get("@#{method}_history")
      end
    end
  end
end
