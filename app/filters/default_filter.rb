class DefaultFilter
  def method_missing(method, *args, &blk)
    method = method.to_sym

    if @klass.enumerations.include?(method)
      add_title_text @klass.enumerations[method].to_a, @klass.human_attribute_name(method)
    end
  end

  def self.collection(*attr)
    new.collection(*attr)
  end

  def self.filter(*attr)
    new.filter(*attr)
  end

  def initialize(klass, options = {})
    @klass = klass
    @current_user = options.delete(:current_user)
    @parent = options.delete(:parent)
  end

  def collection
    filter = {}
    @klass.filter_attributes.each do |attr|
      filter[attr.to_sym] = send(attr)
    end
    filter
  end

  private

  def checkbox_filter(name = I18n.t('active'))
    [name, :checkbox]
  end

  def collect_from(collection, text, attr = :name)
    list = collection.collect { |b| [b.send(attr), b.id] }
    add_title_text(list, text)
  end

  def add_title_text(list, text)
    list.unshift([text, ''])
  end

  def active
    boolean_filter
  end

  private

  def boolean_filter(name = I18n.t('crud.default_states.active'))
    add_title_text [['Sim', true], ['Não', false]], name
  end
end
