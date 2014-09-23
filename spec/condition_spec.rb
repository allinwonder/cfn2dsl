require_relative('spec_helper')

describe Condition do
  let(:json) {
    <<-JSON
      {
        "Conditions": {
          "CreateResources": {
            "Fn::Equals": [
              {
                "Ref": "VPCName"
              },
              "test"
            ]
          },
          "CreateAnotherResources": {
             "Fn::Not" : [{
                "Fn::Equals" : [
                   {"Ref" : "VPCName"},
                       "test"
                 ]
             }]
          }
        }
      }
    JSON
  }

  let(:name) {"CreateResources"}
  let(:vpc_ref) { IntrinsicFunction.new("Ref", parameters: "VPCName") }
  subject{ Condition.new(name, JSON.parse(json)["Conditions"]["CreateResources"]) }

  it "creates condition CreateResources" do
    expect(subject.name).to eq name

    expect(subject.evaluations).to eq IntrinsicFunction.new(
      "Fn::Equals", parameters: [vpc_ref, "test"]
      )
  end

end
