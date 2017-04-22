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
    validation_runner.clear!
    self.class.validator_blocks.each do |validator_block|
      validation_runner.add_validator instance_eval(&validator_block)
    end
    self.class.validators.each do |validator_class|
      validation_runner.add_validator validator_class.new(self)
    end
    self.class.validation_blocks.each do |validation_block|
      instance_eval(&validation_block)
    end
    validation_runner.validate
  end

  def validation_runner
    @validation_runner ||= Valcro::Runner.new(errors)
  end

  module ClassMethods
    def validates_with(validator_class = nil, &block)
      if block_given?
        raise ArgumentError, "cannot provide validator class alongside block" if validator_class
        validator_blocks << block
      else
        raise ArgumentError, "cannot provide block alongside validator class" if block_given?
        validators << validator_class
      end
    end

    def validator_blocks
      @validator_blocks ||= []
    end
    def validators
      @validators ||= []
    end
    def validation_blocks
      @validation_blocks ||= []
    end

    def validate(&block)
      validation_blocks << block
    end
  end
end
