module Mutations
  class Lists::DestroyList < BaseMutation
    argument :id, ID, required: true

    type Types::ListType

    def resolve(id:)
      list = current_user.todo_lists.find_by(id: id)
      list.destroy!
      list
    end
  end
end