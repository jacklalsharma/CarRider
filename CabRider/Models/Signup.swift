//
//  Signup.swift
//  CabRider
//
//  Created by Anurag on 26/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation

class Signup: Codable {
    let success: Bool
    let type: String
    let text: String
    let data: SignupData
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case type = "type"
        case text = "text"
        case data = "data"
    }
    
    init(success: Bool, type: String, text: String, data: SignupData) {
        self.success = success
        self.type = type
        self.text = text
        self.data = data
    }
}

class SignupData: Codable {
    let accesssToken: String
    let currencyCode: String
    let currencySymbol: String
    let user: User2
    
    enum CodingKeys: String, CodingKey {
        case accesssToken = "accesss_token"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case user = "user"
    }
    
    init(accesssToken: String, currencyCode: String, currencySymbol: String, user: User2) {
        self.accesssToken = accesssToken
        self.currencyCode = currencyCode
        self.currencySymbol = currencySymbol
        self.user = user
    }
}

class User2: Codable {
    let fname: String
    let lname: String
    let email: String
    let isEmailVerified: Int
    let countryCode: String
    let mobileNumber: String
    let isMobileNumberVerified: Int
    let fullMobileNumber: String
    let lastAccessTime: String
    let lastAccessedIP: String
    let updatedAt: String
    let createdAt: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case fname = "fname"
        case lname = "lname"
        case email = "email"
        case isEmailVerified = "is_email_verified"
        case countryCode = "country_code"
        case mobileNumber = "mobile_number"
        case isMobileNumberVerified = "is_mobile_number_verified"
        case fullMobileNumber = "full_mobile_number"
        case lastAccessTime = "last_access_time"
        case lastAccessedIP = "last_accessed_ip"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
    }
    
    init(fname: String, lname: String, email: String, isEmailVerified: Int, countryCode: String, mobileNumber: String, isMobileNumberVerified: Int, fullMobileNumber: String, lastAccessTime: String, lastAccessedIP: String, updatedAt: String, createdAt: String, id: Int) {
        self.fname = fname
        self.lname = lname
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.countryCode = countryCode
        self.mobileNumber = mobileNumber
        self.isMobileNumberVerified = isMobileNumberVerified
        self.fullMobileNumber = fullMobileNumber
        self.lastAccessTime = lastAccessTime
        self.lastAccessedIP = lastAccessedIP
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.id = id
    }
}

// MARK: Convenience initializers

extension Signup {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Signup.self, from: data)
        self.init(success: me.success, type: me.type, text: me.text, data: me.data)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension SignupData {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(SignupData.self, from: data)
        self.init(accesssToken: me.accesssToken, currencyCode: me.currencyCode, currencySymbol: me.currencySymbol, user: me.user)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension User2 {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(User.self, from: data)
        self.init(fname: me.fname, lname: me.lname, email: me.email, isEmailVerified: me.isEmailVerified, countryCode: me.countryCode, mobileNumber: me.mobileNumber, isMobileNumberVerified: me.isMobileNumberVerified, fullMobileNumber: me.fullMobileNumber, lastAccessTime: me.lastAccessTime, lastAccessedIP: me.lastAccessedIP, updatedAt: me.updatedAt, createdAt: me.createdAt, id: me.id)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

