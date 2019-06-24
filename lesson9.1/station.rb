# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class Station
  include InstanceCounter
  include Validation

  NAME_PATTERN = /^\w/.freeze

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, NAME_PATTERN

  @stations = []

  def self.all
    @stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.all << self
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

end
