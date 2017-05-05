module AttributeHelper
  def attributes
    attributes = resource_class.list_attributes
    attributes &= params[:attributes].split(',') if params[:attributes]

    associations = resource_class.reflect_on_all_associations

    attributes.map do |attribute|
      next if attribute.blank?
      association = associations.detect { |association| association.foreign_key == attribute }

      # If attribute is an association and is not polymorphic, use the association
      # name instead of the foreign key.
      if association
        association.name unless association.options.include? :polymorphic
      else
        attribute
      end
    end.compact
  end

  def value_by_field_type(value, attribute = nil)
    case value.class.to_s
    when 'String' then
      case attribute
      when 'zipcode' then
        Mask.zipcode(value)
      when 'cpf' then
        Mask.cpf(value)
      when 'cnpj' then
        Mask.cnpj(value)
      when 'phone1' then
        Mask.phone(value)
      else
        value
      end
    when 'ActiveSupport::TimeWithZone' then
      Mask.date_time(value)
    when 'BigDecimal' then
      Mask.decimal(value)
    when 'Date' then
      Mask.date(value)
    when 'FalseClass' then
      "<i class='icon-remove-sign red'></i>".html_safe
    when 'TrueClass' then
      "<i class='icon-ok-sign green'></i>".html_safe
    else
      value.nil? ? '-' : value
    end
  end

  def show_attribute(attribute, object = resource, value = nil)
    show = "<b>#{localized_attribute(object.class, attribute)}</b>: "
    show += value || value_by_field_type(formatted_attribute(object, attribute)).to_s
    show += '<br>'

    show.html_safe
  end

  def real_attribute(attribute)
    if attribute.to_s.end_with?('_id')
      attribute.to_s.split('_id').first
    else
      attribute
    end
  end

  def localized_attribute(klass, attribute_name)
    klass.human_attribute_name real_attribute(attribute_name)
  end

  def formatted_attribute(resource, attribute)
    attribute = real_attribute(attribute).to_s

    human_attr = attribute + '_humanize'
    if resource.respond_to?(human_attr)
      resource.send(human_attr)
    else
      value_by_field_type(resource.send(attribute), attribute)
    end
  end
end
