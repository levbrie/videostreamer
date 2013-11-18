module ApplicationHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(email, options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
		image_tag(gravatar_url, alt: email, class: "gravatar")
	end
end
