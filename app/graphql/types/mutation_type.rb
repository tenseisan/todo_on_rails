module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::Users::SignUp
    field :sign_in, mutation: Mutations::Users::SignIn
    field :create_list, mutation: Mutations::Lists::CreateList
    field :destroy_list, mutation: Mutations::Lists::DestroyList
    field :create_job, mutation: Mutations::Jobs::CreateJob
    field :destroy_job, mutation: Mutations::Jobs::DestroyJob
    field :update_status_by_id, mutation: Mutations::Jobs::UpdateStatusById
  end
end
