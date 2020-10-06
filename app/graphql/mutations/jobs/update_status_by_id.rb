module Mutations
  class Jobs::UpdateStatusById < BaseMutation
    argument :id, ID, required: true
    argument :status, Types::Enum::JobType, required: true

    type Types::ListItemType

    def resolve(id:, status:)
      job = current_user.jobs.find(id)
      job.update(status: status)
      job
    end
  end
end