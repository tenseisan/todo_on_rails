module Mutations
  class Users::SignUp < GraphqlDevise::Mutations::SignUp
    argument :firstName, String, required: true
    argument :lastName, String, required: true

    def resolve(email:, **attrs)
      original_payload = super
      original_payload.merge(user: original_payload[:authenticatable])
    end
  end
end
