require 'spec_helper'

describe Valcro::Error do
  it 'has a property and a message' do
    error = create_error(:prop, 'message')

    error.property.should == :prop
    error.message.should == 'message'
  end

  it 'can coerce to a string' do
    error = create_error
    error.to_s.should == 'prop message'
  end

  it 'does not include property if it is base' do
    error = create_error(:base)
    error.to_s.should == 'message'
  end

  def create_error(prop = :prop, message = 'message')
    Valcro::Error.new(prop, message)
  end
end

