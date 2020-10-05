module Types
  class ListItemType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :status, String, null: true
  end
end
