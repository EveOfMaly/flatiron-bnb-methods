class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  include ReservesModules

  def neighborhood_openings(start_date, end_date)
    openings(start_date, end_date)
  end

end

