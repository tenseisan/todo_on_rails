module Types
  class ListType < Types::BaseObject
    description 'Todo list'
    field :id, ID, null: false
    field :title, String, null: false
    field :jobs, [ListItemType], null: true
  end
end
