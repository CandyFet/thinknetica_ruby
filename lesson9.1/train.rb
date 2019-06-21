# frozen_string_literal: true

require_relative 'manufacturer_name.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train
  include ManufacturerName
  include InstanceCounter
  include Validation

  NUMBER_PATTERN = /^\w{3}-*\w{2}$/.freeze
  NUMBER_ERROR = 'Ошибка! Допустимый формат номера поезда: три буквы или цифры в
  любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы
  или цифры после дефиса.'

  attr_reader :number, :speed, :carriages

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    @@trains[@number] = self
    validate!
    register_instance
  end

  def accelerate(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriage)
    return unless attachable_carriage?(carriage)
    return unless speed.zero?

    @carriages << carriage
  end

  def delete_carriage(carriage)
    @carriages.delete(carriage) if self.speed.zero?
  end

  def add_route(route)
    @route = route
    @station_index = 0
    current_station.arrival(self)
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index.positive?
  end

  def move_next
    return unless next_station

    current_station.departure(self)
    next_station.arrival(self)
    @station_index += 1
  end

  def move_back
    return unless previous_station

    current_station.departure(self)
    previous_station.arrival(self)
    @station_index -= 1
  end

  def to_s
    @number
  end

  protected

  def attachable_carriage?(_carriage)
    raise NotImplementedError
  end

  def validate!
    raise NUMBER_ERROR unless number =~ NUMBER_PATTERN
  end
end
