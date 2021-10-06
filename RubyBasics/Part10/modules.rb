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
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      raise validationError "Attribute's name is not symbol" unless attribute.is_a?(Symbol)

      define_method(attribute) do
        instance_variable_get("@#{attribute}")
      end

      define_method("#{attribute}=") do |value|
        instance_variable_set("@#{attribute}", value)
        instance_variable_set("@#{attribute}_history", []) unless instance_variable_get("@#{attribute}_history")
        instance_variable_get("@#{attribute}_history").push(value)
      end

      define_method("#{attribute}_history") do
        instance_variable_get("@#{attribute}_history")
      end
    end
  end

  def strong_attr_accessor(attributes = {})
    attributes.each do |attribute, class_name|
      raise validationError "Attribute's name is not symbol" unless attribute.is_a?(Symbol)

      define_method(attribute) do
        instance_variable_get("@#{attribute}")
      end

      define_method("#{attribute}=") do |value|
        unless value.is_a?(class_name)
          raise "Expected #{attribute} value's class: #{class_name.name}, given value's class: #{value.class.name}"
        end

        instance_variable_set("@#{attribute}", value)
      end
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    # base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, validation, *params)
      raise validationError "Attribute's name is not symbol" unless attribute.is_a?(Symbol)
      raise validationError "Validation's name is not symbol" unless validation.is_a?(Symbol)

      @validations ||= []
      @validations << [attribute, validation, params]
    end
  end

  # module InstanceMethods
  # end
end
