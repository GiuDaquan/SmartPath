class ReviewsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :check_review_presence!, only: [:new, :create]
	before_action :check_ownership!, only: [:edit, :update, :destroy]

	def index
		@reviews = Review.paginate(page: params[:page])
	end

	def new
		@review = Review.new
	end

	def create
		@review = current_user.build_review(review_params)
		if @review.save
			flash[:success] = "You have succesfully created a review"
			redirect_to reviews_url
		else
			render 'new'
		end
	end

	def edit
        if (user_has_review?)
			@review = current_user.review
		else
			flash[:danger] = "You have not created a review yet"
			redirect_to new_review_path
		end
    end

    def update
		if (user_has_review)
			@review = Review.find(params[:id])
        	if @review.update_attributes(review_params)
            	flash[:success] = "Review updated"
            	redirect_to reviews_path
        	else
            	render 'edit'
        	end
		else
			flash[:danger] = "You have not created a review yet"
			redirect_to new_review_path
    	end
	end

	def destroy
		Review.find(params[:id]).destroy
		flash[:success] = "You have succesfully deleted the review"
		redirect_to reviews_url
	end


	private

	def review_params
		params.require(:review).permit(:content, :rating)
	end

	def check_review_presence!
		if (user_has_review?)
			flash[:danger] = "You have already inserted a review"
			redirect_to reviews_url
		end
	end

	def check_ownership!
		if (!current_user.is_admin)
			if (current_user.review.id != params[:id].to_i)
				flash[:danger] = "You don't have the authorization to perform this action"
				redirect_to reviews_url
			end
		end
	end

	def user_has_review?
		!current_user.review.nil?
	end

end
