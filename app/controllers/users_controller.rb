class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms

    # Display all the Tenants' reviews to Landowner
    @tenant_reviews = Review.where(type: "TenantReview", landowner_id: @user.id)

    @landowner_reviews = Review.where(type: "LandownerReview", tenant_id: @user.id)
  end
end
