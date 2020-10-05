require 'rails_helper'

module Types
  RSpec.describe QueryType, type: :request do
    let(:user) { create(:user) }
    let!(:list) { create(:list, :with_jobs, user: user) }

    describe '#lists' do
      context 'list and tasks present' do
        let(:headers) { user.create_new_auth_token }
        let(:query) do
          <<-GRAPHQL
              query {
                lists {
                  id
                  title
                  jobs {
                    id
                    title
                    status
                  }
                }
              }
          GRAPHQL
        end

        it 'success return lists with tasks' do
          get '/graphql', params: { query: query }, headers: headers
          expect(graphql_response['data']['lists'].size).to eq 1
        end
      end
    end
  end
end