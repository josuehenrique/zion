require 'model_helper'
require 'app/models/user_password_history'
require 'app/models/user_permit'
require 'app/models/permit'
require 'app/models/user'

describe User, type: :model do
  it { should have_many(:user_password_histories) }
  it { should have_many(:user_permits) }
  it { should have_many(:permits) }
  it { should have_many(:roles).class_name('UserPermit') }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }

  it { should callback(:verify_password_history).
    before(:save).if(:encrypted_password_changed?) }

  it { should callback(:downcase_and_remove_secret_phrase_accents).
    before(:save).if(:secret_phrase_changed?) }

  it { should callback(:save_changed_password_on_history).
    after(:save).if(:encrypted_password_changed?) }

  it { should validate_attachment_size(:avatar).in(1..5.megabytes) }

  it { should have_attached_file(:avatar) }

  it { should validate_attachment_content_type(:avatar).
    allowing('image/jpeg', 'image/jpg', 'image/png') }

  describe '#build_role' do
    let(:roles) { double(:roles) }
    let(:user_permit) { double(:user_permit) }

    context 'when has attributes' do
      it 'should build user_attributes objects from hash' do
        subject.stub(roles: roles)
        roles.should_receive(:build).with({ permit_id: 1 }).and_return(user_permit)

        expect(subject.build_role({ permit_id: 1 })).to eq user_permit
      end
    end

    context 'when attributes is blank' do
      it 'should has nothing' do
        subject.stub(roles: roles)

        expect(subject.build_role({})).to eq nil
      end
    end
  end

  describe '#delete_role' do
    let(:roles) { double(:roles) }
    let(:role) { double(:role) }
    let(:user_permit) { double(:user_permit) }

    context 'when has role' do
      it 'should destroy user_permit' do
        subject.stub(roles: roles)
        roles.should_receive(:delete).with(role).and_return(true)

        expect(subject.delete_role(role)).to eq true
      end
    end

    context 'when param role is present' do
      it 'should has nothing' do
        subject.stub(roles: roles)

        expect(subject.delete_role({})).to eq nil
      end
    end
  end

  describe '#active_for_authentication?' do
    it 'should returns true' do
      subject.stub(active?: true)
      expect(subject.active_for_authentication?).to be_truthy
    end

    it 'should returns false' do
      subject.stub(active?: false)
      expect(subject.active_for_authentication?).to be_falsey
    end
  end

  describe '#can_change_me?' do
    let(:user) { double(:user) }

    context 'when user is admin' do
      it 'should returns true' do
        user.stub(admin?: true)

        expect(subject.can_change_me?(user)).to be_truthy
      end
    end

    context 'when user is not admin neither subject' do
      it 'should returns true' do
        user.stub(admin?: false)
        subject.stub(admin?: false)

        expect(subject.can_change_me?(user)).to be_truthy
      end
    end

    context 'when user is not admin and subject is admin' do
      it 'should returns false' do
        user.stub(admin?: false)
        subject.stub(admin?: true)

        expect(subject.can_change_me?(user)).to be_falsey
      end
    end
  end

  describe '#is_equal_me?' do
    it 'should returns true' do
      expect(subject.is_equal_me?(subject)).to be_truthy
    end

    it 'should returns false' do
      expect(subject.is_equal_me?('')).to be_falsey
    end
  end

  describe '#to_s' do
    it 'should returns name' do
      subject.stub(name: 'Noemi Mendes')
      expect(subject.to_s).to eq 'Noemi Mendes'
    end
  end

  describe '#can_change?' do
    let(:user) { double(:user) }

    context 'when is not eq me and can change me' do
      it 'should returns true' do
        user.stub(admin?: true)

        expect(subject.can_change?(user)).to be_truthy
      end
    end

    context 'when is eq me and can change me' do
      it 'should returns false' do
        expect(subject.can_change?(subject)).to be_falsey
      end
    end

    context 'when is not eq me and cannot change me' do
      it 'should returns false' do
        subject.stub(admin?: true)
        user.stub(admin?: false)
        expect(subject.can_change?(user)).to be_falsey
      end
    end
  end
end
