module StarsHelper

	def name_heading(star)
		if false
			aliases = ['Anjelica']
			# aliases = Star.where(alias_of: star.id)
			"#{star.name} <em class=\"small\">AKA: #{aliases.join(', ')}</em>"
		else
			star.name
		end
	end

end
