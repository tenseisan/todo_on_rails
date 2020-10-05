module Mutations
  class Lists::CreateJob < BaseMutation
    argument :list_id, ID, required: true

    type Types::ListItemType

    def resolve(list_id:, title:)
      list = current_user.todo_lists.find(id)
      list.jobs.create!(title: title)
    end
  end
end