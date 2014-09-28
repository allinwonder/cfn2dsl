require_relative 'spec_helper'

describe Resource do

  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/load-based-auto-scaling.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}

  let(:resource_name) {"NotificationTopic"}
  subject{Resource.new(resource_name, cfn_json['Resources'][resource_name])}

  it "has name NotificationTopic" do
    expect(subject.name).to eq resource_name
  end

  it "has type 'AWS::SNS::Topic'" do
    expect(subject.type).to eq "AWS::SNS::Topic"
  end

  it "has property Subscription" do
    property = subject.properties['Subscription']
    expect(property).to eq [ {
            "Endpoint" => IntrinsicFunction.new("Ref", "OperatorEmail"),
            "Protocol" => "email" }
          ]
  end
end
