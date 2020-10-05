require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignIn, type: :request do
      let!(:user) { create(:user, :with_token) }
      let(:wrong_password) { 'some_invalid_password' }

      describe '#resolve' do
        context 'user exist and valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                userLogin(
                  email:                "#{user.email}"
                  password:             "password"
                ) {
                  user { id email firstName lastName }
                  credentials { accessToken uid tokenType client expiry }
                }
              }
            GRAPHQL
          end

          it 'success login user' do
            post '/graphql_auth', params: { query: query }
            expect(graphql_response['data']['userLogin']['user']).to be
            expect(graphql_response['data']['userLogin']['credentials']).to be
          end
        end

        context 'invalid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                userLogin(
                  email:                "#{user.email}"
                  password:             "#{wrong_password}"
                ) {
                  user { id email firstName lastName }
                  credentials { accessToken uid tokenType client expiry }
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