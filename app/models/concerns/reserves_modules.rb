module ReservesModules    
    extend ActiveSupport::Concern

    def openings(start_date, end_date)
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

        city_openings_avail  << Listing.find(3) #broken adds lsiting there

        city_openings_not_avail.each do |res_not_avail| 
            city_openings_avail.each do |res_avail| 
                if res_not_avail != res_avail
                    final_avail << res_avail
                end
            end
        end
    #prints out a array with collection if available and empty if not.
        final_avail
    end
    
    class_methods do 
        def highest_ratio_res_to_listings
            max_ratio = self.ratio_reservation_to_listings 
            self.find(max_ratio["id"])  
        end
        
        def ratio_reservation_to_listings 
            array = []
        
             self.all.each do |city| 
               array << city.attributes
             end
            
            

             counter = array.each { |city| city[:count] = 0}
             counter = array.each { |city| city[:number_of_listings] = 0}
            
            

             Reservation.all.each do |reservation|
              counter.each do |object|
                if reservation.listing.neighborhood.city_id == object["id"]
                   object[:count]+= 1
                 end
               end
             end

         
        
             Listing.all.each do |listing|
              counter.each do |object|
                if listing.neighborhood.city_id == object["id"]
                  object[:number_of_listings]+= 1
                end
              end
            end      
            @max_ratio_reservation = counter.max_by {|k| k[:count].nonzero?.to_f || 1 / k[:number_of_listings].nonzero?.to_f || 1}
          end
  


          def most_res
              most_reservations = self.find_most_reservations
                self.find( most_reservations["id"])
          end
          
    
        def find_most_reservations
            array = []
          
            self.all.each do |city| 
              array << city.attributes
            end
          
          

            counter = array.each { |city| city[:count] = 0}
            counter = array.each { |city| city[:number_of_listings] = 0}
        
    
            Reservation.all.each do |reservation|
              counter.each do |object|
                if reservation.listing.neighborhood.city_id == object["id"]
                  object[:count]+= 1
                end
              end
            end
            
  
            @max_reservation_city = counter.max_by {|k| k[:count].nonzero?.to_f || 1 / k[:number_of_listings].nonzero?.to_f || 1}
          
          end
        end
        
      end
      
    
      
