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
      raise "Attribute's name is not symbol" unless attribute.is_a?(Symbol)

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
      raise "Attribute's name is not symbol" unless attribute.is_a?(Symbol)

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
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    # Не использовал моссив параметров, так как это не имеет смысла в контексте
    # наших задач. Мы везде обходимся одним параметром, не вижу смысла усложнять код
    # Если бы в задаче было validate :number, :format, /A-Z{0,3}/, /dsad/ и мы бы
    # проверяли на соответствие одному или другому, в массиве был бы смысл

    def validate(attribute, validation_type, parameter = nil)
      raise "Attribute's name is not symbol" unless attribute.is_a?(Symbol)
      raise "Validation's name is not symbol" unless validation_type.is_a?(Symbol)

      @validations ||= []
      @validations << { attribute: attribute, validation_type: validation_type, parameter: parameter }
    end
  end

  module InstanceMethods
    def validate!
      errors = []
      self.class.validations.each do |validation|
        case validation[:validation_type]
        when :presence
          validate_presence(validation[:attribute], errors)
        when :type
          validate_type(validation[:attribute], validation[:parameter], errors)
        when :format
          validate_format(validation[:attribute], validation[:parameter], errors)
        end
      end
      raise errors.join('. ') unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(attribute, errors)
      if instance_variable_get("@#{attribute}").nil? || instance_variable_get("@#{attribute}") == ''
        errors << "#{attribute} is nil/empty line"
      end
    end

    def validate_type(attribute, correct_class, errors)
      unless instance_variable_get("@#{attribute}").is_a?(correct_class)
        errors << "#{attribute}'s class: #{instance_variable_get("@#{attribute}").class}, expected class: #{correct_class.name}"
      end
    end

    def validate_format(attribute, format, errors)
      errors << "#{attribute}'s format is invalid" if instance_variable_get("@#{attribute}") !~ format
    end
  end
end
