# frozen_string_literal: true

require "valcro/error"
require "valcro/error_list"
require "valcro/runner"

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
    validation_runner.clear!
    self.class.validators.each do |validator_class|
      validator = if validator_class.respond_to?(:build)
        validator_class.build(self)
      else
        validator_class.new(self)
      end
      validation_runner.add_validator validator
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
    def validates_with(validator_class)
      validators << validator_class
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
