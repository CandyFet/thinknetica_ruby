# frozen_string_literal: true

require_relative 'carriage.rb'
class PassengerCarriage < Carriage
  def occupy_capacity
    super(1)
  end
end
