require 'spec_helper'

describe Valcro::ErrorList, 'adding errors' do
  it 'supports adding via <<' do
    list = Valcro::ErrorList.new
    list << Valcro::Error.new(:prop, 'message')

    list.should have(1).errors
  end
end

describe Valcro::ErrorList, '#add' do
  it 'finds and agregates error messages' do
    list = Valcro::ErrorList.new

    list[:one].should == []

    list.add(:one, 'message one')
    list.add(:two, 'message two')
    list.add(:one, 'another message one')

    list[:one].should == ['message one', 'another message one']
  end
end

describe Valcro::ErrorList, '#full_messages' do
  it 'gives a collection of messages' do
    list = Valcro::ErrorList.new

    list.add :prop, 'one'
    list.add :prop, 'two'
    list.add :prop,'three'

    list.full_messages.should == ["prop one", "prop two", "prop three"]
  end
end

describe Valcro::ErrorList, '#to_s' do
  it 'gives messages as one string' do
    list = Valcro::ErrorList.new

    list.add :prop, 'one'
    list.add :prop, 'two'
    list.add :prop, 'three'

    list.to_s.should == "prop one prop two prop three"
  end
end

describe Valcro::ErrorList, '#any?' do
  it 'is true when there are errors 'do
    list = Valcro::ErrorList.new

    list.any?.should be_false
    list.add :prop, 'some error'

    list.any?.should be_true
  end
end
