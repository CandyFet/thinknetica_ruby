# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      prefix = "#{arg}_history"
      var = "@#{arg}".to_sym
      var_with_history = "@#{prefix}".to_sym

      define_method(arg) { instance_variable_get(var) }
      define_method(prefix) { instance_variable_get(var_with_history) }

      define_method("#{arg}=") do |value|
        previous_value = instance_variable_get(var)
        history = instance_variable_get(var_with_history) || []
        history << previous_value unless history.empty?
        instance_variable_set(var_with_history, history)
        instance_variable_set(var, value)
      end
    end
  end

  def strong_attr_accessor(arg, klass)
    var_arg = "@#{arg}".to_sym

    define_method(arg) { instance_variable_get(var_arg) }
    define_method("#{arg}=".to_sym) do |value|
      raise ArgumentError unless value.is_a?(klass)

      instance_variable_set(var_arg, value)
    end
  end
end
