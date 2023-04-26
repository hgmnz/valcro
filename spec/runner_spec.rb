# frozen_string_literal: true

require "spec_helper"

describe Valcro::Runner do
  it "can store validators" do
    runner = Valcro::Runner.new
    runner.add_validator :some_validator
    expect(runner.validators).to have(1).validator
  end

  it "runs validators" do
    error_list = Valcro::ErrorList.new
    runner = Valcro::Runner.new(error_list)
    runner.add_validator lambda { |errors| errors.add :foo, "Huge mistake" }

    runner.validate

    expect(error_list.any?).to be_truthy
  end
end
