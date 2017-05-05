class GenericSearcher
  def self.search(*attributes)
    new(*attributes).search
  end

  def initialize(klass, options)
    @klass = klass

    @page = options.fetch(:page)

    @attr = options.delete(:attr)
    @keyword = options.delete(:keyword)
    @records = options.delete(:records)
    @filter = options.delete(:filter)
    @current_user = options.delete(:current_user)
  end

  def search
    search = basic_search

    search = make_filter(search) if @filter

    search
  end

  protected

  def basic_search
    search = @records || @klass

    unless @keyword.blank?
      if is_foreign_key?
        search = search.includes(fk_relation).
          where("#{fk_relation_table}.name LIKE ?", '%' + @keyword + '%').
          references(fk_relation)
      elsif id?
        search = search.where(id: @keyword)
      else
        search = search.where(@klass.arel_table[@attr.to_sym].matches("%#{@keyword}%"))
      end
    end

    search.ordered
  end

  def make_filter(search)
    @filter.delete_if { |_, v| v.blank? }

    search = filter(search) if @filter

    search
  end

  private

  def filter(search)
    @filter.each do |attribute, value|
      search = make_search(search, attribute, value)
    end

    search
  end

  def make_search(search, attribute, value)
    attr = attribute.to_sym

    if @klass.date_attribute?(attribute)
      search = search_date(search, attr, value)
    else
      search = search.where(attr => value)
    end

    search
  end

  def search_date(search, attr, value)
    begin
      dates = value.split(' - ').collect(&:to_date)
    rescue
      return search
    end

    search.where(attr => dates[0]..dates[1])
  end

  def id?
    @attr.to_sym.equal? :id
  end

  def is_foreign_key?
    @attr.end_with?('_id')
  end

  def fk_relation
    @attr.gsub('_id', '')
  end

  def fk_relation_table
    @klass.reflections[fk_relation.to_sym].class_name.underscore.pluralize
  end
end
