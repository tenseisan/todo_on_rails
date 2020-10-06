require 'rails_helper'

module Mutations
  module Jobs
    RSpec.describe CreateJob, type: :request do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }
      let(:list) { create(:list, user: user) }
      let(:title) { Faker::Book.title }
      let(:job) { create(:list_item, list: list, title: title) }

      describe '#resolve' do
        context 'valid query' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                createJob(listId: "#{list.id}"
                          title: "#{title}"
                          )
                {
                  id title status
                }
              }
            GRAPHQL
          end
          it 'create job' do
            expect { post '/graphql', params: { query: query }, headers: headers }.to change { ListItem.count }.from(0).to(1)
            expect(graphql_response['data']['createJob']['id']).to be
            expect(graphql_response['data']['createJob']['status']).to be
          end
        end
      end
    end
  end
end