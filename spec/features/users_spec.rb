require 'feature_helper'

feature 'Users', type: :feature do
  background do
    sign_in
  end

  scenario 'Create user' do
    navigate 'Administração > Usuários'
    click_link 'Novo'

    fill_in 'Nome', with: 'Josué Henrique Ferreira da Silva'
    fill_in 'Email', with: 'teste@teste.com.br'
    attach_file 'Imagem', "#{Rails.root}/spec/fixtures/images/test.jpg"

    fill_in 'Senha', with: '15016515'
    fill_in 'Confirmar Senha', with: '15016515'

    click_button 'Salvar'

    expect(page).to have_success 'Usuário cadastrado com sucesso.'
  end

  scenario 'Edit/Update' do
    user = FactoryGirl.cache(:user_peter, active: true)

    navigate 'Administração > Usuários'

    within_row_list(user.name) { click_link 'Editar' }

    fill_in 'Email', with: 'pedro_cesar@hotmail.com'

    click_button 'Salvar'

    expect(page).to have_success 'Usuário editado com sucesso.'
  end

  scenario 'Inactive/Active' do
    sign_out
    sign_in make_user_with_permits
    user = FactoryGirl.cache(
      :user,
      email: 'teste@gmail.com',
      name: 'João',
      active: true,
      admin: false
    )

    navigate 'Administração > Usuários'

    within_row_list(user.name) { click_link 'Inativar' }

    expect(page).to have_success 'Inativado com sucesso.'

    click_link 'Ativo'

    within('tbody') { expect(page).to_not have_content 'teste@gmail.com' }

    click_link 'Inativo'

    within('tbody') { expect(page).to have_content 'teste@gmail.com' }

    click_link 'Ativar'

    expect(page).to have_success 'Ativado com sucesso.'

    within('tbody') { expect(page).to have_content 'teste@gmail.com' }

    click_link 'Inativo'

    within('tbody') { expect(page).to_not have_content 'teste@gmail.com' }
  end

  context 'CRUD permits' do
    background do
      sign_out
      sign_in make_user_with_permits
    end

    scenario 'user not have permit in enterprise resource' do
      expect(page).to_not have_link 'Empresa'
    end

    context 'for edit action' do
      scenario 'user not have access in edit on list' do
        permit_id = @user.permits.by_action('edit').pluck(:id)
        UserPermit.where(permit_id: permit_id).destroy_all

        navigate 'Administração > Usuários'

        within_row_list(@user.name) { expect(page).to_not have_link 'Editar' }
      end

      scenario 'user not have access in edit on show' do
        permit_id = @user.permits.by_action('edit').pluck(:id)
        UserPermit.where(permit_id: permit_id).destroy_all

        navigate 'Administração > Usuários'

        within_row_list(@user.name) { click_link @user.name }

        within('.form-buttons') { expect(page).to_not have_link 'Editar' }
      end
    end

    scenario 'user not have access in show on list' do
      permit_id = @user.permits.by_action('show').pluck(:id)
      UserPermit.where(permit_id: permit_id).destroy_all

      navigate 'Administração > Usuários'

      within_row_list(@user.name) { expect(page).to_not have_link 'Visualizar' }
    end

    scenario 'user not have access in inactivate on list' do
      permit_id = @user.permits.by_action('inactivate').pluck(:id)
      UserPermit.where(permit_id: permit_id).destroy_all

      navigate 'Administração > Usuários'

      within_row_list(@user.name) { expect(page).to_not have_link 'Inativar' }
    end

    scenario 'user not have access in new on index' do
      permit_id = @user.permits.by_action('new').pluck(:id)
      UserPermit.where(permit_id: permit_id).destroy_all

      navigate 'Administração > Usuários'

      within_row_list(@user.name) { expect(page).to_not have_link 'Novo' }
    end

    scenario 'user not have access in activate on list' do
      permit_id = @user.permits.by_action('activate').pluck(:id)
      UserPermit.where(permit_id: permit_id).destroy_all
      current_user.update_column(:active, false)

      navigate 'Administração > Usuários'

      click_link 'Inativo'

      within_row_list(current_user.name) { expect(page).to_not have_link 'Ativar' }
    end
  end

  scenario 'administrator user could not see permits link' do
    navigate 'Administração > Usuários'

    click_link 'Josué'
    expect(page).to_not have_link 'Permissões'
  end

  scenario 'administrator user could not access permits page' do
    visit(administration_user_permits_path(user_id: current_user))

    within('h1') do
      expect(page).to_not have_content 'Permissões'
    end
  end

  scenario 'administrator user could not inactive yourself through window' do
    navigate 'Administração > Usuários'
    expect(page).to_not have_link 'Inativar'
  end

  scenario 'administrator user could not inactive yourself through url' do
    visit(inactivate_administration_user_path current_user)
    expect(page).to have_content 'Usuários'
  end

  scenario 'inactive user could not login' do
    sign_out
    user = FactoryGirl.cache(:user_peter, active: false)
    sign_in user

    expect(page).to have_info 'O usuário informado está inativo.'
  end

  scenario 'try generate new password without fill form' do
    sign_out

    click_link 'Esqueceu sua senha?'

    click_button 'Resetar a senha'

    expect(page).to have_warning 'Preencha os campos, por favor.'
  end

  scenario 'try generate new password' do
    sign_out

    click_link 'Esqueceu sua senha?'

    fill_in 'Email', with: current_user.email
    fill_in 'Palavra Secreta', with: 'JoSué123'
    click_button 'Resetar a senha'

    expect(page).to have_primary 'Senha alterada com sucesso! Nova senha: '
  end

  context 'Locked user'do
    scenario 'locked user could not access other pages' do
      sign_out
      user = FactoryGirl.cache(:user_peter, locked: true)
      sign_in user

      visit(edit_administration_user_path(current_user))

      expect(page).to have_warning 'Para continuar altere a sua senha.'
    end

    scenario 'locked user should change the password' do
      sign_out
      user = FactoryGirl.cache(:user_peter, locked: true)
      sign_in user

      fill_in 'Senha', with: '15016515'
      fill_in 'Confirmar Senha', with: '15016515'
      fill_in 'Palavra Secreta', with: 'pasta'

      click_button 'Salvar'

      expect(page).to have_success 'Sua conta foi atualizada com sucesso.'
    end
  end

  scenario 'unlocked user could not access unlock window' do
    visit(unlock_administration_user_profile_path(current_user))
    expect(page).to_not have_field 'Senha'
  end

  def make_user_with_permits
    @user = FactoryGirl.cache(:user_peter)

    permits = {
      edit: 'Editar', index: 'Listar', inactivate: 'Inativar',
      activate: 'Ativar', create: 'Criar', show: 'Visualizar'
    }

    permits.map do |action, name|
      FactoryGirl.cache(
        :permit,
        name: name,
        controller: 'users',
        action: action.to_s,
        modulus: 'administration'
      )
    end

    Permit.all.each do |permit|
      FactoryGirl.cache(:user_permit, permit: permit, user: @user)
    end

    @user
  end
end
