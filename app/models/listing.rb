class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :title, :description, :title, :listing_type,:address, :price, :neighborhood,  presence: true 
  after_save :change_user_host_status_on_creation
  before_destroy :change_host_status_to_false_when_empty
  
  
  
  def average_review_rating
    ratings_array = reviews.map {|review| review.rating}
    average_review_rating =  ratings_array.sum.to_f / ratings_array.count.to_f #sum/number
  end
  
  private

 

  def change_user_host_status_on_creation 
    if Listing.find_by(host: host)
      host.update(host: true)
    end
  end

  def change_host_status_to_false_when_empty

    #empty means all host listings are made 
    if Listing.where(host: host).where.not(id: id).empty?
      host.update(host: false)
    end
  end



end
