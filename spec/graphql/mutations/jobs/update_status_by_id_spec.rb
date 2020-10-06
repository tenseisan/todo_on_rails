require 'rails_helper'

module Mutations
  module Jobs
    RSpec.describe UpdateStatusById, type: :request do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }
      let(:list) { create(:list, user: user) }
      let!(:job) { create(:list_item, list: list) }

      describe '#resolve' do
        context 'valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                updateStatusById(id: "#{job.id}" status: COMPLETED)
                {
                  id status
                }
              },
            GRAPHQL
          end

          it 'update job status' do
            post '/graphql', params: { query: query }, headers: headers
            job.reload
            expect(job.status).to eq 'completed'
            expect(graphql_response['data']['updateStatusById']['id']).to be
          end
        end
      end
    end
  end
end