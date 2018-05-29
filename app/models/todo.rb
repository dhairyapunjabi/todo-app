class Todo < ApplicationRecord
  has_many :articles , dependent: :destroy
end
