class Review < ActiveRecord::Base
  validates :rating, presence: true 
  validates :description, presence: true 

  validate :checked_out
  validate :reservation_accepted


  #invalid if reservation presence true, reservationstatus != accepted and checkout
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"


  # # how do you know checkout has happened?
  # def valid_reservation
  #   if !self.reservation.presence && (self.reservation.status == "accepted" ||  self.reservation.status == nil) && self.reservation.checkout.presence
  #     errors.add(:valid_reservation, "review cannot be accepted")
  #   end
  # end
  
  private
  
    def checked_out
      if reservation && reservation.checkout > Date.today
        errors.add(:reservation, "Reservation must have ended to leave a review.")
      end
    end
  
    def reservation_accepted
      if reservation.try(:status) != 'accepted'
        errors.add(:reservation, "Reservation must be accepted to leave a review.")
      end
    end
 

end
