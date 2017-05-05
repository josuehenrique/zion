require 'spec_helper'

describe Permit do
  it 'should validate uniqueness of action' do
    FactoryGirl.create(:permit)
    user = FactoryGirl.build(:permit)
    user.save
    expect(user.errors[:action]).to include 'já está em uso'
  end
end
