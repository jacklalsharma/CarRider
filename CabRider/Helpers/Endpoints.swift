//
//  Endpoints.swift
//  CabRider
//
//  Created by Anurag on 24/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation

class Endpoints{
    static let BASE_URL = "http://139.59.79.130"
    static let LOGIN_URL = BASE_URL + "/api/v1/user/login"
    static let SIGNUP_URL = BASE_URL + "/api/v1/user/register" ;
    static let REQUEST_OTP = BASE_URL + "/api/v1/user/otp/send" ;
    static let VERIFY_OTP = BASE_URL + "/api/v1/user/otp/verify" ;
    static let REQUEST_PASSWORD_RESET = BASE_URL + "/api/v1/user/password-reset-request";
    static let RESET_PASSWORD = BASE_URL + "/api/v1/user/password-reset" ;
    static let VEHICLE_TYPES = BASE_URL + "/api/v1/user/vehicle-types";
    static let NEARBY_DRIVERS = BASE_URL + "/api/v1/user/nearby-drivers";
}
