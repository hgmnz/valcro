require 'valcro/error'
require 'valcro/error_list'
require 'valcro/runner'

module Valcro
  def self.included(base)
    base.extend ClassMethods
  end

  def errors
    @error_list ||= Valcro::ErrorList.new
  end

  def valid?
    !errors.any?
  end

  def error_messages
    errors.to_s
  end

  def validate
    errors.clear!
    self.class.validators.each do |validator_class|
      validation_runner.add_validator validator_class.new(self)
    end
    validation_runner.validate
  end

  def validation_runner
    @validation_runner ||= Valcro::Runner.new(errors)
  end

  module ClassMethods
    def validates_with(validator_class)
      validators << validator_class
    end

    def validators
      @validators ||= []
    end
  end
end
