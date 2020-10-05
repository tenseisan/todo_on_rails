Rails.application.routes.draw do
  # отдельный раут и схема для auth, регистрация/логин/логаут
  mount_graphql_devise_for 'User', at: 'graphql_auth', operations: {
      sign_up: Mutations::Users::SignUp,
      login: Mutations::Users::SignIn
  }
  post "/graphql", to: "graphql#execute"
  get "/graphql", to: "graphql#execute"


  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end
end
