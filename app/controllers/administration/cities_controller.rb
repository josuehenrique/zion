class Administration::CitiesController < CrudController
  nested_belongs_to :country, :state

  protected

  def end_of_association_chain
    apply_scopes City.by_state params[:state_id]
  end
end
