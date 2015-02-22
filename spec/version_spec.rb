require 'spec_helper'

RSpec.describe Cfn2dsl do
  subject { Cfn2dsl::VERSION }

  it 'contains version number' do
    expect(subject).to match(/\d+\.\d+\.\d+/)
  end
end
