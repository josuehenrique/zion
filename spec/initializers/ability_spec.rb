require 'unit_helper'
require 'cancan/ability'
require 'cancan/rule'
require 'cancan/matchers'
require 'active_support/core_ext/object/blank'
require 'config/initializers/ability'

describe Ability do
  let :role do
    double('role', action: 'access', controller: 'something')
  end

  let :user do
    double('user', :admin? => false, user_permits: [role])
  end

  let :admin do
    double('user', :admin? => true)
  end

  it 'alias modal to read' do
    ability = Ability.new
    ability.can(:read, :something)

    expect(ability).to be_able_to :modal, :something
  end

  it 'should be able to access all if user is admin' do
    ability = Ability.new(admin)

    expect(ability).to be_able_to :access, :all
  end

  it 'should not be able to access all if user is admin' do
    ability = Ability.new(user)

    expect(ability).to_not be_able_to :access, :all
  end

  it 'should be able to access which roles permits' do
    ability = Ability.new(user)

    expect(ability).to be_able_to :read, :something
    expect(ability).to be_able_to :create, :something
    expect(ability).to be_able_to :update, :something
    expect(ability).to be_able_to :destroy, :something
  end
end
