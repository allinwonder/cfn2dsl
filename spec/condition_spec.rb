require_relative('spec_helper')

describe Condition do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/basic-amazon-redshift-cluster.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}

  let(:name) {"IsMultiNodeCluster"}

  subject{ Condition.new(name, cfn_json["Conditions"][name]) }

  it "has name IsMultiNodeCluster" do
    expect(subject.name).to eq "IsMultiNodeCluster"
  end

  it "has evaluation Fn::Equals" do
    expect(subject.evaluations).to eq IntrinsicFunction.new(
      "Fn::Equals",
      [
        IntrinsicFunction.new("Ref", "ClusterType"),
        "multi-node"
      ]
    )
  end

end
