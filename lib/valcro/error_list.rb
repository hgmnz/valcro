module Valcro
  class ErrorList
    attr_accessor :errors
    def initialize
      @errors = []
    end

    def <<(error)
      @errors << error
    end

    def add(prop, message)
      @errors << Valcro::Error.new(prop, message)
    end

    def [](prop)
      @errors.select { |error| error.property == prop }.map(&:message) || []
    end

    def clear!
      @errors = []
    end

    def full_messages
      @errors.map(&:to_s)
    end

    def to_s
      full_messages.join(' ')
    end

    def any?
      @errors.any?
    end
  end
end
