class LandownerReviewsController < ApplicationController
  def create
    #Check if the rental exist (room, tenant, landowner)

    @rental = Rental.where(
              id: landowner_review_params[:rental_id],
              room_id: landowner_review_params[:room_id],
              user_id: landowner_review_params[:tenant_id]
              ).first

    if !@rental.nil?
      @has_reviewed = LandownerReview.where(
                        rental_id: @rental.id,
                        tenant_id: landowner_review_params[:tenant_id]
                      ).first

      if @has_reviewed.nil?
        #Enable review
          @landowner_review = current_user.landowner_reviews.create(landowner_review_params)
          flash[:success] = "Your review has been submitted"
      else
          flash[:success] = "You have already reviewed this Rental"
      end
    else
      flash[:alert] = "There is no rental has been made😞"
    end
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @landowner_review = Review.find(params[:id])
    @landowner_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Your review has been removed😃")
  end

  private
    def landowner_review_params
      params.require(:landowner_review).permit(:comment, :star, :room_id, :rental_id, :tenant_id)
    end
  end
