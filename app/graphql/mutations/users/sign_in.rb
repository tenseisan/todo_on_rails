module Mutations
  class Users::SignIn < GraphqlDevise::Mutations::Login
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      original_payload = super

      original_payload.merge(user: original_payload[:authenticatable])
    end
  end
end
