class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.includes(:employee, :bicycle).order(:start_time)

    if params[:start_date].present? || params[:end_date].present?
      @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Reservation.minimum(:start_time)&.to_date
      @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Reservation.maximum(:end_time)&.to_date

      @reservations = @reservations.where(start_time: @start_date.beginning_of_day..@end_date.end_of_day) if @start_date && @end_date
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "rezervacijas_#{@start_date || 'visas'}_#{@end_date || 'visas'}",
               template: 'reservations/index',
               layout: 'pdf',
               page_size: 'A4',
               encoding: 'UTF-8'
      end
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy!

    respond_to do |format|
      format.html { redirect_to reservations_path, status: :see_other, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:employee_id, :bicycle_id, :start_time, :end_time, :purpose, :status)
    end
end
