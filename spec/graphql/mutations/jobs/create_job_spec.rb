require 'rails_helper'

module Mutations
  module Jobs
    RSpec.describe CreateJob, type: :request do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }
      let!(:list) { create(:list, user: user) }
      let(:title) { create(:list_item, list: list, title: title) }

      describe '#create_list' do
        context 'valid quiery' do
          let(:query) do
            <<-GRAPHQL
              mutation {
                createJob(title: "#{title}")
                {
                  id title
                }
              }
            GRAPHQL
          end
          it 'create list' do
            expect { post '/graphql', params: { query: query }, headers: headers }.to change { List.count }.from(0).to(1)
            binding.pry
            expect(graphql_response['data']['id']).to be
          end
        end
      end
    end
  end
end