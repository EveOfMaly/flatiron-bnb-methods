class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout,  presence: true 
  validate :cannot_make_reservation_on_own_listing
  validate :available
  validate :checkin_before_checkout
  validate :checkin_and_checkout_not_same
  
  include ReservesModules

  def duration 
    (checkout - checkin).to_i
  end

  def total_price
    listing.price * duration
  end



  private 


  def available 
    Reservation.where(listing_id: listing.id).where.not(id: id).each do |r|
      booked_dates = r.checkin..r.checkout
      if booked_dates === checkin || booked_dates === checkout
        errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
      end
    end
  end

  def cannot_make_reservation_on_own_listing
    if guest_id == listing.host_id
      errors.add(:guest, "Can't book your own apartment.")
    end
  end

  def checkin_before_checkout
    if checkin && checkout && checkin > checkout 
      errors.add(:guest, "Check in must be before checkout")
    end 
  end

  def checkin_and_checkout_not_same
    if checkin && checkout && checkin == checkout 
      errors.add(:guest, "Checkin and checkout must be different days")
    end 
  end

 




end
