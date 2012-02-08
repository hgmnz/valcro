module Valcro
  class Error
    attr_accessor :property, :message

    def initialize(property, message)
      @property = property
      @message  = message
    end

    def to_s
      if @property == :base
        message
      else
        "#{property.to_s} #{message}"
      end
    end
  end
end
