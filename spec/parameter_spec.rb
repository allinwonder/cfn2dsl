require_relative 'spec_helper'

describe Parameter do

  let(:json) do
    <<-EOF
      {
        "DNSDomain": {
          "Description": "The DNS domain that this VPC will host",
          "Type": "String",
          "Default": "this.is.a.fake.domain",
          "Foo" : "bar"
        }
      }
    EOF
  end

  let(:name) { "DNSDomain" }
  subject { Parameter.new(name, JSON.parse(json)[name]) }

  context("a known element") do
    it "includes the :default attribute with provided value" do
      expect(subject.default).to eq("this.is.a.fake.domain")
    end
  end

  context("empty element") do
    it "excludes :allowed_values attribute" do
      expect(subject.allowed_values).to be_nil
    end
  end

  context("unknown element") do
    it "never set unknown attribute" do
      expect(subject.instance_variable_get('@foo')).to be_nil
      expect(subject.instance_variable_get('@Foo')).to be_nil
    end
  end
end
