module FilterHelper
  def filters
    resource_class.filter_class.new(
      resource_class,
      current_user: current_user,
      parent: (parent if defined?(parent))
    ).collection
  end

  def checkbox?(options)
    options && options.include?(:checkbox)
  end

  def filter_value(filter)
    params[:search] && params[:search][:filter] ? params[:search][:filter][filter] : nil
  end

  def hide_options?(filter, options)
    return false if checkbox?(options)

    filter_value(filter).blank?
  end

  def filter_link(options, filter)
    return if checkbox?(options)

    name = options ? options.first[0] : localized_attribute(resource_class, filter)

    link_to name, '#', id: "link_#{filter}", onclick: "hide_link('#{filter}')",
            style: "#{'display:none;' unless filter_value(filter).blank?}"
  end
end
