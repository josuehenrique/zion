class UserFilter < DefaultFilter
  def admin
    boolean_filter(I18n.t 'activerecord.attributes.user.admin')
  end
end
