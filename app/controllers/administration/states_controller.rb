class Administration::StatesController < CrudController
  belongs_to :country

  protected

  def end_of_association_chain
    apply_scopes State.by_country params[:country_id]
  end
end
