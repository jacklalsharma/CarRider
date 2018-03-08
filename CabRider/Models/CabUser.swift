//
//  CabUser.swift
//  CabRider
//
//  Created by Anurag on 27/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation

import Realm
import RealmSwift

class CabUser : Object{
    @objc dynamic var fName = "" ;
    @objc dynamic var lName = "" ;
    @objc dynamic var email = "" ;
    @objc dynamic var accessToken = "" ;
    @objc dynamic var id = 0 ;
    @objc dynamic var countryCode = "" ;
    @objc dynamic var mobileNumber = "" ;
    
}
