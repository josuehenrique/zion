module Administration::MembersHelper
  def naturalness_state_id(object)
    object.new_record? ? nil : object.naturalness.state_id 
  end

  def naturalness_states(object)
    object.new_record? ? [] : object.naturalness.state.country.states
  end

  def naturalness_city_id(object)
    object.new_record? ? nil : object.naturalness_id
  end

  def naturalness_cities(object)
    object.new_record? ? [] : object.naturalness.state.cities
  end

  def naturalness_country_id(object)
    object.new_record? ? nil : object.naturalness.state.country_id 
  end
end
