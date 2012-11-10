namespace :reservations do
  desc "Remove expired reservations"
  task :clear_expired => :environment do
    Reservation.expired.delete_all
  end
end
