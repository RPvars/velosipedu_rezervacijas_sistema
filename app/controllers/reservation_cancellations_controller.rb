class ReservationCancellationsController < ApplicationController
  def cancel
    @reservation = Reservation.find(params[:id])
    
    if @reservation.update(status: 'cancelled')
      redirect_to root_path, notice: 'Rezervācija veiksmīgi atcelta.'
    else
      redirect_to root_path, alert: 'Neizdevās atcelt rezervāciju.'
    end
  end
end
