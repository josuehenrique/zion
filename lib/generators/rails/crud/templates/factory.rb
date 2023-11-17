FactoryGirl.define do
  factory :<%= class_name.underscore %> do
    <%- attributes.each do |attribute| -%>
    <%= attribute.name %> <%= attribute.default.inspect %>
    <%- end -%>
  end
end
