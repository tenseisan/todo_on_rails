module Mutations
  class Lists::CreateList < BaseMutation
    argument :title, String, required: true

    type Types::ListType

    def resolve(title:)
      list = current_user.todo_lists.new(title: title)
      list.save!
      list
    end
  end
end