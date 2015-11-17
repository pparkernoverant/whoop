Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  username { Faker::Internet.user_name }
end