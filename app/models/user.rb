class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :validatable
  include GraphqlDevise::Concerns::Model

  has_many :todo_lists, class_name: 'List', foreign_key: 'user_id'
  has_many :jobs, through: :todo_lists, class_name: 'ListItem'
end
