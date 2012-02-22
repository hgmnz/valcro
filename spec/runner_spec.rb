require 'spec_helper'

describe Valcro::Runner do
  it 'can store validators' do
    runner = Valcro::Runner.new
    runner.add_validator :some_validator
    runner.validators.should have(1).validator
  end

  it 'runs validators' do
    error_list = Valcro::ErrorList.new
    runner     = Valcro::Runner.new(error_list)
    runner.add_validator lambda { |errors| errors.add :foo, 'Huge mistake' }

    runner.validate

    error_list.any?.should be_true
  end
end
