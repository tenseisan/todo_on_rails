module Mutations
  class Lists::updateJob < BaseMutation
    JOBSTATUS = GraphQL::EnumType.define do
      name "Status"
      value("active")
      value("completed")
    end

    argument :id, ID, required: true
    argument :status, JOBSTATUS

    type Types::ListItemType

    def resolve(id:, **args)
      job = current_user.jobs.find(id)
      job.update(args)
      job
    end
  end
end