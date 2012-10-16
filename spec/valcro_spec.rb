require 'spec_helper'

describe Valcro do
  class TestClass
    include Valcro
  end

  it 'is valid with no validations defined' do
    expect(TestClass.new.valid?).to be_true
  end
end

describe Valcro, 'adding some errors' do
  class TestClass
    include Valcro
  end

  it 'gives access to the error list' do
    test_instance = TestClass.new

    test_instance.errors.add(:foo, 'too foo for my taste')

    expect(test_instance.errors[:foo]).to have(1).error

    expect(test_instance).not_to be_valid
  end
end

describe Valcro, 'validators' do
  class StatusFail
    def initialize(context)
      @context = context
    end
    def call(errors)
      errors.add(:status, 'big mistake') if @context.status == 'fail'
    end
  end

  class TestClass
    include Valcro
    attr_accessor :status
    def status
      @status ||= "fail"
    end
    validates_with StatusFail
  end

  it 'can be added validators' do
    test_instance = TestClass.new

    test_instance.validate
    expect(test_instance).not_to be_valid
  end

  it 'clears validations on subsequent runs' do
    test_instance = TestClass.new

    test_instance.validate
    expect(test_instance).not_to be_valid

    test_instance.status = 'win'
    test_instance.validate
    expect(test_instance).to be_valid
  end
end

describe Valcro, '#error_messages' do
  class TestClass
    include Valcro
  end

  it 'delegates to errors' do
    test_instance = TestClass.new
    test_instance.stub!(errors: double(to_s: 'some errors'))

    expect(test_instance.error_messages).to eq('some errors')
  end
end
