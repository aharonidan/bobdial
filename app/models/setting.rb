class Setting < ApplicationRecord
	# before_save { self.value = value.parameterize(separator: '_') }
	after_create { User.calculate_points }

	def self.wall
		Setting.where(name: 'wall').take.value.split(',').uniq.map(&:to_i)
	end

	def self.clear_wall
		Setting.where(name: 'wall').update(value: '[]')
	end

	def self.read user
		current = wall
		current << user.id

		Setting.where(name: 'wall').update(value: current.uniq.to_s)
	end

end
