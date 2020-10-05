require 'rails_helper'

module Mutations
  module Lists
    RSpec.describe DestroyList, type: :request do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }
      let!(:list) { create(:list, user: user) }

      describe '#destroy_list' do
        context 'valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                destroyList(id: "#{list.id}")
                {
                  id
                }
              }
            GRAPHQL
          end
          it 'destroy' do
            expect { post '/graphql', params: { query: query }, headers: headers }.to change { List.count }.from(1).to 0
            expect(graphql_response['data']['id']).to be
          end
        end
      end
    end
  end
end