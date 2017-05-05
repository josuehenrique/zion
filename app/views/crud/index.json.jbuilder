json.array! collection do |resource|
  json.id                   resource.id
  json.label                resource.to_s
end
