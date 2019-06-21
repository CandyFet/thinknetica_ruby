# frozen_string_literal: true

require_relative 'manufacturer_name.rb'
class Carriage
  include ManufacturerName

  ATTRIBUTE_ERROR = 'Ошибка! Атрибут класса должен быть числом.'
  NOT_ENOUGH_CAPACITY = 'Ошибка! Вагон заполнен.'

  attr_reader :capacity

  def initialize(capacity)
    @capacity = capacity
    @occupied_capacity = 0
    validate!
  end

  def occupy_capacity(value)
    raise NOT_ENOUGH_CAPACITY if value > available_capacity

    @occupied_capacity += value
  end

  def available_capacity
    @capacity - @occupied_capacity
  end

  protected

  def validate!
    raise ATTRIBUTE_ERROR if @capacity.class != Integer
  end
end
