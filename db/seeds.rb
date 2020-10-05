user = FactoryBot.create(:user)
list = FactoryBot.create(:list, user: user)

5.times do
  FactoryBot.create(:list_item, list: list)
end
