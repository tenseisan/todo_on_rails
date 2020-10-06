module Mutations
  class Jobs::CreateJob < BaseMutation
    argument :list_id, ID, required: true
    argument :title, String, required: true

    type Types::ListItemType

    def resolve(list_id:, title:)
      list = current_user.todo_lists.find(list_id)
      list.jobs.create!(title: title)
    end
  end
end