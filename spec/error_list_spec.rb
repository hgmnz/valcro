require 'spec_helper'

describe Valcro::ErrorList, 'adding errors' do
  it 'supports adding via <<' do
    list = Valcro::ErrorList.new
    list << Valcro::Error.new(:prop, 'message')

    expect(list.errors.length).to eq(1)
  end
end

describe Valcro::ErrorList, '#add' do
  it 'finds and agregates error messages' do
    list = Valcro::ErrorList.new

    expect(list[:one]).to be_empty

    list.add(:one, 'message one')
    list.add(:two, 'message two')
    list.add(:one, 'another message one')

    expect(list[:one]).to eq(['message one', 'another message one'])
  end
end

describe Valcro::ErrorList, '#full_messages' do
  it 'gives a collection of messages' do
    list = Valcro::ErrorList.new

    list.add :prop, 'one'
    list.add :prop, 'two'
    list.add :prop,'three'

    expect(list.full_messages).to eq(["prop one", "prop two", "prop three"])
  end
end

describe Valcro::ErrorList, '#to_s' do
  it 'gives messages as one string' do
    list = Valcro::ErrorList.new

    list.add :prop, 'one'
    list.add :prop, 'two'
    list.add :prop, 'three'

    expect(list.to_s).to eq("prop one prop two prop three")
  end
end

describe Valcro::ErrorList, '#any?' do
  it 'is true when there are errors 'do
    list = Valcro::ErrorList.new

    expect(list.any?).to be_falsey
    list.add :prop, 'some error'

    expect(list.any?).to be_truthy
  end
end

describe Valcro::ErrorList, '#none?' do
  it 'is true when there no errors 'do
    list = Valcro::ErrorList.new

    expect(list.none?).to be_truthy
    list.add :prop, 'some error'

    expect(list.none?).to be_falsey
  end
end

describe Valcro::ErrorList, '#clear!' do
  it 'removes all errors' do
    list = Valcro::ErrorList.new
    list.add :prop, 'some error'
    expect(list.any?).to be_truthy

    list.clear!
    expect(list.any?).to be_falsey
  end
end
