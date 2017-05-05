require 'model_helper'
require 'app/models/user_permit'
require 'app/models/permit'

describe Permit, type: :model do
  it { should have_many(:user_permits).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:controller) }
  it { should validate_presence_of(:action) }
  it { should validate_presence_of(:modulus) }

  describe '#controller_name' do
    it 'should returns controller name translated' do
      subject.stub(controller: 'posts')
      expect(subject.controller_name).to eq 'Cargos'
    end
  end
end
