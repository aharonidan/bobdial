class Setting < ApplicationRecord
	before_save { self.value = value.parameterize(separator: '_') }
	after_create { User.calculate_points }
end
