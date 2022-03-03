class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
    #find all listings for the city?
    
      #Listing -> we need to get a list of all listings with the same city.id 
      #Reservations -> we need to get a list of all reservations in the same city
      #filter by start_date, end_date



    #available listings in city
     @listings_in_city =  Listing.all.select {|listing| listing.neighborhood.city_id == self.id}
    #available reservations for a city 
     @reservations_in_city = Reservation.all.select {|reservation| reservation.listing.neighborhood.city_id == self.id}
   
      city_openings = []

      @reservations_in_city.each do |reservation|
        #if there is overlap 
        if (start_date.to_date <= reservation.checkout) && (end_date.to_date >= reservation.checkin) 
          #don't add listings that overlapp
          city_openings << reservation.listing
        end
      end

      city_openings
   

  end

  def self.highest_ratio_res_to_listings
    #returns the city with the # of reservations  per listing
    counter = 0 
    City.all.each do |city| 
      Reservation.all.each do |reservation|
        if city.id == reservation.city_id 
          

        end
      end
    end


  end

end

