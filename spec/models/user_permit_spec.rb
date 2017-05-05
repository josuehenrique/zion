require 'model_helper'
require 'app/models/user'
require 'app/models/permit'
require 'app/models/user_permit'

describe UserPermit, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:permit) }

  it { should delegate(:controller_name).to(:permit) }
  it { should delegate(:controller).to(:permit) }
  it { should delegate(:modulus).to(:permit) }
  it { should delegate(:action).to(:permit) }
end
