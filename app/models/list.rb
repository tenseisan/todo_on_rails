class List < ApplicationRecord
  belongs_to :user
  has_many :jobs, class_name: 'ListItem', foreign_key: 'list_id', dependent: :destroy
end
