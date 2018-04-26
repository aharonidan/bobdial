module ApplicationHelper
	def message_class category
		case category
		when 'error'
			'is-danger'
		when 'notice'
			'is-warning'
		when 'success'
			'is-success'
		end
	end

end
