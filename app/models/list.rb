class List < ApplicationRecord
  belongs_to :user
  has_many :jobs, class_name: 'ListItem', dependent: :destroy
end
