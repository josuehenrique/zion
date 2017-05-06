require 'spec_helper'

describe User do
  subject { FactoryGirl.cache(:user) }

  describe '#verify_password_history' do
    context 'when password belongs to history' do
      it 'should returns error base message' do
        subject.update_attributes(password: '12131415')
        subject.update_attributes(password: '12131415')

        expect(subject.errors[:base]).to include 'Essa senha já foi utilizada recentemente.'
      end
    end
  end

  describe '#downcase_and_remove_secret_phrase_accents' do
    context 'when secret phrase have a accents' do
      it 'should remove accents before save' do
        subject.update_attributes(secret_phrase: 'o nome da minha mãe')
        expect(subject.secret_phrase).to eq 'o nome da minha mae'
      end
    end

    context 'when secret phrase have a capital letters' do
      it 'should downcase letters before save' do
        subject.update_attributes(secret_phrase: 'O Nome Do Meu Pai')
        expect(subject.secret_phrase).to eq 'o nome do meu pai'
      end
    end
  end

  describe '#save_changed_password_on_history' do
    context 'when password was changed'do
      it 'should have one history on save' do
        expect(subject.user_password_histories.count).to eq 1
      end

      it 'should save password history' do
        subject.update_attributes(password: '12131415')
        encrypted_password = subject.user_password_histories.last.encrypted_password
        expect(Devise::Encryptor.compare(User, encrypted_password, '12131415')).to eq true
      end
    end
  end

  it 'should validate uniqueness of email' do
    FactoryGirl.create(:user)
    user = FactoryGirl.build(:user)
    user.save
    expect(user.errors[:email]).to include 'já está em uso'
  end
end
