class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  include ReservesModules


  def neighbor_openenings(start_date, end_date)
    openings(start_date, end_date)
  end

end
