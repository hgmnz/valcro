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
  let(:test_class) do
    Class.new do
    include Valcro
    end
  end

  it 'gives access to the error list' do
    test_instance = test_class.new

    test_instance.errors.add(:foo, 'too foo for my taste')

    expect(test_instance.errors[:foo]).to have(1).error

    expect(test_instance).not_to be_valid
  end
end

describe Valcro, 'validators' do
  class StatusFailValidator
    def initialize(context)
      @context = context
    end
    def call(errors)
      errors.add(:status, 'big mistake') if @context.status == 'fail'
    end
  end

  let(:test_class) do
    Class.new do
      include Valcro
      attr_accessor :status
      def status
        @status ||= "fail"
      end
      validates_with StatusFailValidator
    end
  end

  it 'can be added validators' do
    test_instance = test_class.new

    test_instance.validate
    expect(test_instance).not_to be_valid
  end

  it 'clears validations on subsequent runs' do
    test_instance = test_class.new

    test_instance.validate
    expect(test_instance).not_to be_valid

    test_instance.status = 'win'
    test_instance.validate
    expect(test_instance).to be_valid
  end
end

describe Valcro, '#error_messages' do
  let(:test_class) do
    Class.new { include Valcro }
  end

  it 'delegates to errors' do
    test_instance = test_class.new
    test_instance.stub!(errors: double(to_s: 'some errors'))

    expect(test_instance.error_messages).to eq('some errors')
  end
end

describe Valcro, '.validate' do
  let(:test_class) do
    Class.new do
      include Valcro
      attr_accessor :works
      validate do
        errors.add(:works, 'does not work') unless works
      end
    end
  end

  it 'sets validations on the included class' do
    test_instance = test_class.new
    test_instance.works = false
    test_instance.validate
    expect(test_instance.valid?).to be_false

    test_instance.works = true
    test_instance.validate
    expect(test_instance.valid?).to be_true
  end
end
