class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.json
  def index
    authenticate_restaurant!
    @reservations = restaurant.reservations.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = restaurant.reservations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = restaurant.reservations.new
    @check_time_res = restaurant.reservations.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = restaurant.reservations.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = restaurant.reservations.new(params[:reservation])
    @check_time_res = restaurant.reservations.new

    respond_to do |format|
      if @reservation.save
        ReservationsMailer.confirmation(@reservation).deliver

        format.html { redirect_to root_path, notice: "Your reservation was successfully created. Your confirmation number is #{@reservation.id}" }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = restaurant.reservations.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to root_path, notice: "Reservation updated successfully" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = restaurant.reservations.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  # POST /reservations/check_availability
  def check_availability
    @reservation = restaurant.reservations.new
    @check_time_res = restaurant.reservations.new(params[:reservation])
    @available_tables = restaurant.available_tables_for_span(@check_time_res)

    respond_to do |format|
      format.html { render action: "new" }
    end
  end

  def find
    @reservation = Reservation.find(params[:id])
    redirect_to edit_reservation_path(@reservation)
  end
end
