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

	def link_stars_in_str(stars, str)

		stars_progression = []
		stars.each do |star|
			link = link_to star.name, star, title: star.name
			str = str.gsub(star.name, link)
			unless str.to_s.include? link.to_s
				stars_progression << star
			end
		end if stars.any?

		uncredited = []
		stars_progression.each do |star|
			first_name = star.name.split(" ").first
			link = link_to first_name, star, title: star.name
			str = str.gsub(first_name, link)
			unless str.to_s.include? link.to_s
				uncredited << star
			end
		end if stars_progression.any?

		uncredited_str = []
		uncredited.each do |star|
			first_name = star.name.split(" ").first
			link = link_to first_name, star, title: star.name, class: 'small'
			uncredited_str << link
		end if uncredited.any?

		str = str + ' ' + uncredited_str.join('<small>, </small>') if uncredited_str.any?

		str.html_safe
	rescue
		str
	end

end
