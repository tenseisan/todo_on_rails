module GraphQL
  module MutationsHelper
    def sign_up_mutation(input = {})
      %(
        mutation SignUp(
          $firstName: String!,
          $lastName: String!,
          $email: String!,
          $password: String!,
          $passwordConfirmation: String!
        ) {
          userSignUp(
            firstName: $firstName,
            lastName: $lastName,
            email: $email,
            password: $password,
            passwordConfirmation: $passwordConfirmation
          )
            {
              id
              firstName
              lastName
              email
            }
        }
      )
    end
  end
end