module Types
  class ListItemType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :status, Types::Enum::JobType, null: false
  end
end
