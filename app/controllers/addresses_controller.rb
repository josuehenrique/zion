class AddressesController < ApplicationController
  respond_to :json, :js

  def post_offices_address
    address = Correios::CEP::AddressFinder.get(params[:zipcode])
    state = State.by_acronym(address[:state]).first
    city = state.cities.by_name(address[:city]).first

    render json: address.merge(state_id: state.id, city_id: city.id)
  end
end
