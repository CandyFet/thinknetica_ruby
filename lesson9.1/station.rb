# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class Station
  include InstanceCounter
  include Validation

  NAME_PATTERN = /^\w/.freeze
  NAME_ERROR = 'Ошибка! Имя станции должно начинаться с цифры или с буквы'

  attr_reader :name, :trains

  @stations = []

  def self.all
    @stations
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    validate!
    register_instance
  end

  def arrival(train)
    trains << train
  end

  def departure(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def to_s
    @name
  end

  protected

  def validate!
    raise NAME_ERROR unless name =~ NAME_PATTERN
  end
end
