require 'spec_helper'

describe Valcro::Error do
  it 'has a property and a message' do
    error = create_error(:prop, 'message')

    expect(error.property).to eq(:prop)
    expect(error.message).to eq('message')
  end

  it 'can coerce to a string' do
    error = create_error
    expect(error.to_s).to eq('prop message')
  end

  it 'does not include property if it is base' do
    error = create_error(:base)
    expect(error.to_s).to eq('message')
  end

  it 'does not include property if told to ignore' do
    error = create_error(:foo, 'message', include_property_in_to_s: false)
    expect(error.to_s).to eq('message')
  end

  def create_error(prop = :prop, message = 'message', opts = {})
    Valcro::Error.new(prop, message, opts)
  end
end

