require 'request_helper'

feature '<%= controller_class_name %>' do
  background do
    sign_in
  end

  scenario 'create/update/destroy <%= singular_name %>' do
    <%- if associations? -%>
    make_dependencies!

    <%- end -%>
    navigate '<%= dashboard %> > <%= plural %>'

    click_link 'Novo'

    <%- fields.each do |name, i18n| -%>
      <%- if selects.include?(name) -%>
    select '<%= name %>', from: '<%= i18n %>'
      <%- elsif associations.map(&:name).include?(name) -%>
    select '<%= name %>', from: '<%= i18n %>'
      <%- else -%>
    fill_in '<%= i18n %>', with: '<%= name %>'
      <%- end -%>
    <%- end -%>

    click_button 'Salvar'

    expect(page).to have_notice '<%= singular %> <%= female? ? "criada" : "criado" %> com sucesso.'

    click_link 'Editar'

    <%- fields.each do |name, i18n| -%>
      <%- if selects.include?(name) -%>
    expect(page).to have_select '<%= i18n %>', selected: '<%= name %>'
      <%- else -%>
    expect(page).to have_field '<%= i18n %>', with: '<%= name %>'
      <%- end -%>
    <%- end -%>

    <%- fields.each do |name, i18n| -%>
      <%- if selects.include?(name) -%>
    select '<%= name %>', from: '<%= i18n %>'
      <%- elsif associations.map(&:name).include?(name) -%>
    select '<%= name %>', from: '<%= i18n %>'
      <%- else -%>
    fill_in '<%= i18n %>', with: '<%= name %>'
      <%- end -%>
    <%- end -%>

    click_button 'Salvar'

    expect(page).to have_notice '<%= singular %> <%= female? ? "editada" : "editado" %> com sucesso.'

    click_link 'Editar'

    <%- fields.each do |name, i18n| -%>
      <%- if selects.include?(name) -%>
    expect(page).to have_select '<%= i18n %>', selected: '<%= name %>'
      <%- else -%>
    expect(page).to have_field '<%= i18n %>', with: '<%= name %>'
      <%- end -%>
    <%- end -%>

    click_link 'Voltar'

    click_link 'Deletar', confirm: true

    expect(page).to have_notice '<%= singular %> <%= female? ? "deletada" : "deletado" %> com sucesso.'

    <%- attributes.each do |attribute| -%>
    expect(page).to_not have_content '<%= attribute.name %>'
    <%- end -%>
  end

  <%- if associations? -%>
  def make_dependencies!
    <%- associations.each do |association| -%>
      create(:<%= association.name %>)
    <%- end -%>
  end
  <%- end -%>
end
