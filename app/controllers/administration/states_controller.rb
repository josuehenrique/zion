class Administration::StatesController < CrudController
  def update
    update! do
      edit_administration_state_path(country_id: params[:country_id])
    end
  end

  def create
    create! do
      administration_states_path(redirect_index)
    end
  end

  def activate
    activate!(redirect_index(false))
  end

  def inactivate
    inactivate!(redirect_index)
  end

  protected

  def end_of_association_chain
    apply_scopes State.by_country params[:country_id]
  end

  def redirect_index(active=nil)
    {country_id: params[:country_id],
     active: active}
  end
end
