# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class Route
  include InstanceCounter
  include Validation

  CLASS_ERROR = 'Ошибка! В маршруте могут участвовать только станции.'
  LOGIC_ERROR = 'Ошибка! Начальная станция не должна равняться конечной.'

  attr_reader :stations

  def initialize(start_station, end_station)
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

  protected

  def validate!
    raise CLASS_ERROR unless stations.all? { |station| station.is_a?(Station) }
    raise LOGIC_ERROR if stations.first == stations.last
  end
end
