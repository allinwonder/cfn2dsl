require_relative 'spec_helper'

describe Mapping do

  let(:json) do
    <<-JSON
{
  "Mappings": {
    "AWSRegionToAMI": {
      "us-east-1": {
        "32": "ami-12345678",
        "64": "ami-abcdefgh"
      },
      "us-west-1": {
        "32": "ami-09876543",
        "64": "ami-hgfedcba"
      }
    }
  }
}
    JSON
  end

  let(:map_name) { "AWSRegionToAMI" }
  subject{ Mapping.new(map_name, JSON.parse(json)["Mappings"][map_name]) }

  it "creates a mapping ofAWSRegionToAMI" do
    expect(subject.name).to eq "AWSRegionToAMI"
    expect(subject.values.keys).to contain_exactly("us-east-1", "us-west-1")
  end

end

