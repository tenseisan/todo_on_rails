require 'rails_helper'

module Mutations
  module Jobs
    RSpec.describe DestroyJob, type: :request do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }
      let(:list) { create(:list, user: user) }
      let!(:job) { create(:list_item, list: list) }

      describe '#resolve' do
        context 'valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                destroyJob(id: "#{job.id}")
                {
                  id
                }
              }
            GRAPHQL
          end
          it 'destroy job' do
            expect { post '/graphql', params: { query: query }, headers: headers }.to change { ListItem.count }.from(1).to(0)
            expect(gql_response['data']['destroyJob']['id']).to be
          end
        end
      end
    end
  end
end