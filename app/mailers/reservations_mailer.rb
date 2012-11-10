class ReservationsMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirmation(reservation)
    @reservation = reservation

    mail to: reservation.email
  end
end
