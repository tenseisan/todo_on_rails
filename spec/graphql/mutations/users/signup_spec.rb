require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignUp, type: :request do
      let(:email) { Faker::Internet.email }
      let(:first_name) { Faker::Name.first_name }
      let(:last_name) { Faker::Name.last_name }
      let(:password) { 'password' }

      describe '#resolve' do
        context 'valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                userSignUp(
                  email:                "#{email}"
                  firstName:            "#{first_name}"
                  lastName:             "#{last_name}"
                  password:             "#{password}"
                  passwordConfirmation: "#{password}"
                ) {
                  credentials { accessToken }
                }
              }
            GRAPHQL
          end

          it 'success create user' do
            post '/graphql_auth', params: { query: query }
            expect(User.count).to eq 1
            expect(graphql_response['data']['userSignUp']['credentials']['accessToken']).to be
          end
        end
        context 'invalid query' do
          let!(:old_user) { create(:user) }

          let(:query) do
            <<-GRAPHQL
              mutation {
                userSignUp(
                  email:                "#{old_user.email}"
                  firstName:            "#{first_name}"
                  lastName:             "#{last_name}"
                  password:             "#{password}"
                  passwordConfirmation: "#{password}"
                ) {
                  credentials { accessToken }
                }
              }
            GRAPHQL
          end
          it 'return error' do
            post '/graphql_auth', params: { query: query }
            expect(graphql_response['errors']).to be # TODO helper for detailed errors
          end
        end
      end
    end
  end
end