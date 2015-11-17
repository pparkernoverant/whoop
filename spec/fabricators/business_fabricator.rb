Fabricator(:business) do
  name { Faker::Name.first_name + '\'s Cafe'}
end