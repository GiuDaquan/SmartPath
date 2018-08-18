module ReviewsHelper

	def user_has_review
		!current_user.review.nil?
	end
end
