# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.validations = []
  end

  module ClassMethods

    attr_accessor :validations

    def validate(name, type, format = nil)
      @validations << { name: name, type: type, format: format }
    end
  end

  module InstanceMethods
    VALIDATION_ERROR = 'Не поддерживаемый вид проверки'
    PRESENCE_ERROR = 'Строка не должна быть пустой'
    FORMAT_ERROR = 'Значение не соответсвует формату'
    TYPE_ERROR = 'Не поддерживаемый тип значения'

    def valid?
      validate!
      true
    rescue StandardError, VALIDATION_ERROR
      false
    end

    private

    def validate!
      self.class.validations.each do |validation|
        var_name = "@#{validation[:name]}".to_sym
        value = instance_variable_get(var_name)

        send("#{validation[:type]}_validation", value, *validation[:format])
      end
    end

    def presence_validation(value, _)
      raise StandardError, PRESENCE_ERROR if value.nil? || value == ''
    end

    def format_validation(value, format)
      raise StandardError, FORMAT_ERROR if value !~ format
    end

    def type_validation(value, type)
      raise StandardError, TYPE_ERROR unless value.is_a?(type)
    end
  end
end
