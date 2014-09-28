require_relative 'spec_helper'

describe IntrinsicFunction do


  it "creates intrinsic function Fn::Select()" do
    fn = IntrinsicFunction.new("Fn::Select", [0, [ "apples", "grapes", "oranges", "mangoes" ]])

    expect(fn.name).to eq "Fn::Select"
    expect(fn.parameters).to eq [0, [ "apples", "grapes", "oranges", "mangoes" ]]
  end

  it "creates intrinsic function Ref('AWS::Region')" do
    fn = IntrinsicFunction.new("Ref", "AWS::Region")

    expect(fn.name).to eq "Ref"
    expect(fn.parameters).to eq "AWS::Region"
  end
end
