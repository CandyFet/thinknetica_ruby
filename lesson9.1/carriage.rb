# frozen_string_literal: true

require_relative 'manufacturer_name.rb'
class Carriage
  include ManufacturerName
  include Validation

  NOT_ENOUGH_CAPACITY = 'Ошибка! Вагон заполнен.'

  attr_reader :capacity

  validate :capacity, :type, Numeric

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
end
