module Mutations
  class Jobs::DestroyJob < BaseMutation
    argument :id, ID, required: true

    type Types::ListItemType

    def resolve(id:)
      job = current_user.jobs.find(id)
      job.destroy!
      job
    end
  end
end