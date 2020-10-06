class ListItem < ApplicationRecord
  belongs_to :list

  enum status: { active: 0, completed: 1 }
end
