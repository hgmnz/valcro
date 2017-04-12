module Valcro
  class Error
    attr_accessor :property, :message

    def initialize(property, message, options={})
      @property = property
      @message  = message
      @options = options
    end

    def to_s
      if @property == :base || @options[:include_property_in_to_s] == false
        message
      else
        "#{property.to_s} #{message}"
      end
    end
  end
end
