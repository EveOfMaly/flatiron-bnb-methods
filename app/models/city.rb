class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)


    #available listings in city
     @listings_in_city =  Listing.all.select {|listing| listing.neighborhood.city_id == self.id}
    #available reservations for a city 
     @reservations_in_city = Reservation.all.select {|reservation| reservation.listing.neighborhood.city_id == self.id}

     @reservations_in_city 


    
      city_openings_avail = []
      city_openings_not_avail = []
      final_avail = []


      @reservations_in_city.each do |reservation|
        #if there is no overlap 
        if ((start_date.to_date <= reservation.checkout) && (reservation.checkin >=  end_date.to_date)) 
          #don't add listings that overlapp
          city_openings_not_avail << reservation.listing
        else
          city_openings_avail << reservation.listing
        end
      end

      city_openings_avail  << Listing.find(3)

      city_openings_not_avail.each do |res_not_avail| 
        city_openings_avail.each do |res_avail| 
          if res_not_avail != res_avail
            final_avail << res_avail
          end
        end
      end

      final_avail

  end

  # def self.highest_ratio_res_to_listings
  #   #returns the city with the # of reservations  per listing
  #   counter = {}
  #   highest_ratio
  #   City.all.each do |city| 
  #     Reservation.all.each do |reservation|
  #       if city.id == reservation.city_id 
          
  #       end
  #     end
  #   end


  # end

end

