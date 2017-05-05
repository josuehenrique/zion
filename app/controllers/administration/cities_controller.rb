class Administration::CitiesController < CrudController
  def update
    update! do
      edit_administration_city_path(country_id: params[:country_id], state_id: params[:state_id])
    end
  end

  def create
    create! do
      administration_cities_path(redirect_index)
    end
  end

  def activate
    activate!(redirect_index(false))
  end

  def inactivate
    inactivate!(redirect_index)
  end

  protected

  def redirect_index(active=nil)
    {country_id: params[:country_id],
     state_id: params[:state_id],
     active: active}
  end

  def end_of_association_chain
    apply_scopes City.by_state params[:state_id]
  end
end