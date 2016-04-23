module Sortable
	extend ActiveSupport::Concern

	def sort
		klass = params[:controller].classify.constantize
		sortables = params[klass.to_s.underscore.to_sym]

		sortables.each_with_index do |id, index|
			klass.update id, position: index+1
		end
		render nothing: true
	end

end
