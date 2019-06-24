# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class Route
  include InstanceCounter
  include Validation

  LOGIC_ERROR = 'Ошибка! Начальная станция не должна равняться конечной.'

  attr_reader :stations

  validate :start_station, :type, Station
  validate :end_station, :type, Station

  def initialize(start_station, end_station)

    raise LOGIC_ERROR if start_station == end_station

    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    return if [stations.first, stations.last].include?(station)

    stations.delete(station)
  end

  def to_s
    [stations.first, stations.last].join(' - ')
  end


end
