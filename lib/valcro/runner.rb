module Valcro
  class Runner
    attr_accessor :validators, :error_list
    def initialize(error_list = ErrorList.new)
      @validators = []
      @error_list = error_list
    end

    def add_validator(validator)
      @validators << validator
    end

    def validate
      @validators.each do |validator|
        validator.call error_list
      end
    end
  end
end
