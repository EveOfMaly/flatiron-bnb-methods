class Review < ActiveRecord::Base
  validates :rating, presence: true 
  validates :description, presence: true 
  # validate :valid_reservation


  #invalid if reservation presence true, reservationstatus != accepted and checkout
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"


  #how do you know checkout has happened?
  # && self.guest.status != "accepted"
  # def valid_reservation
  #   if !self.reservation.presence && (self.reservation.status == "accepted" ||  self.reservation.status == nil) && self.reservation.checkout.presence
  #     errors.add(:valid_reservation, "review cannot be accepted")
  #   end
  # end

end
