class RentalsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.find(params[:room_id])

    if current_user == room.user
      flash[:alert] = "Don't be silly, that's your own 🏠"
    else
      start_date = Date.parse(rental_params[:start_date])
      end_date = start_date + (rental_params[:rent_period].to_i).months

      @rental = current_user.rentals.build(rental_params)
      @rental.room = room
      @rental.price = room.price
      @rental.end_date = end_date
      @rental.total = room.price * (rental_params[:rent_period].to_i)
      @rental.save

    flash[:notice] = "All Set 🤗"
    end
    redirect_to room
  end

  def your_landowners
    @landowners= current_user.rentals.order(start_date: :asc)
  end

  def your_rentals
    @rooms = current_user.rooms
  end

  def your_rentals
    @rooms = current_user.rooms
  end

  private
    def rental_params
        params.require(:rental).permit(:start_date, :rent_period)
    end
end
