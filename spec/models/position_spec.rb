require 'rails_helper'

describe Position do
  before { @position = FactoryGirl.build(:position) }

  subject { @position }

  it { should respond_to(:name) }

  let(:position) {FactoryGirl.create :position}

  describe "validate" do
    context "create is valid" do
      it {is_expected.to be_valid}
    end
  end
end