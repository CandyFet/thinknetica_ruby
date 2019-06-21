# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class PassengerTrain < Train
  include InstanceCounter
  include Validation

  def initialize(number)
    super
  end

  protected

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
