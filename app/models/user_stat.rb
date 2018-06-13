class UserStat < ApplicationRecord
	belongs_to :stat
	belongs_to :user
end
