module Types
  class QueryType < Types::BaseObject
    field :lists, [ListType], null: false

    def lists
      current_user.todo_lists
    end
  end
end
