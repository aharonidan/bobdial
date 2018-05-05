class Report < ApplicationRecord
  belongs_to :user
  has_one :account, through: :user
end
