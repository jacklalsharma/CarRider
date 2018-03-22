//
//  MyPlace.swift
//  CabRider
//
//  Created by Anurag on 22/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation

class MyPlace{
    
    var address : String!
    var lat : Double!
    var lng : Double!
    
    func setAddress(address : String){
        self.address = address;
    }
    
    func getAddress()->String{
        return self.address;
    }
    
    func setLng(lng : Double){
        self.lng = lng;
    }
    
    func getLng()->Double{
        return self.lng;
    }
    
    func setLat(lat : Double){
        self.lat = lat;
    }
    
    func getLat() -> Double {
        return self.lat;
    }
    
}
