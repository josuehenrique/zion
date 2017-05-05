class Administration::PermitsController < CrudController
  belongs_to :user

  def index
    if parent.admin?
      redirect_to administration_user_path(parent)
    else
      @permits = Permit.all.group_by(&:modulus)
      @modulus = @permits.keys
      @permits = params[:module_name] ? @permits.select{|k, _| k == params[:module_name] } : []
      super
    end
  end

  def new
    RoleDefinition.update(parent, params[:cntl])
  end

  def save_changes
    if parent.update_attributes(params[:user])
      flash[:notice] = 'Atualizado com sucesso'
    else
      flash[:alert] = 'Não foi possível atualizar'
    end

    redirect_to action: :new
  end
end
