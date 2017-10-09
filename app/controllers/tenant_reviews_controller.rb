class TenantReviewsController < ApplicationController
  def create
    #Check if the rental exist (room, tenant, landowner)

    @rental = Rental.where(
              id: tenant_review_params[:rental_id],
              room_id: tenant_review_params[:room_id],
              ).first

    if !@rental.nil? && @rental.room.user.id == tenant_review_params[:landowner_id].to_i
      @has_reviewed = TenantReview.where(
                        rental_id: @rental.id,
                        landowner_id: tenant_review_params[:landowner_id]
                      ).first

      if @has_reviewed.nil?
        #Enable review
          @tenant_review = current_user.tenant_reviews.create(tenant_review_params)
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
    @tenant_review = Review.find(params[:id])
    @tenant_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Your review has been removed😃")
  end

  private
    def tenant_review_params
      params.require(:tenant_review).permit(:comment, :star, :room_id, :rental_id, :landowner_id)
    end
  end
