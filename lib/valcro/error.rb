# frozen_string_literal: true

module Valcro
  class Error
    attr_accessor :property, :message

    def initialize(property, message)
      @property = property
      @message = message
    end

    def to_s
      if @property == :base
        message
      else
        "#{property} #{message}"
      end
    end
  end
end
