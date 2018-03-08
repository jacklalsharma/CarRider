//
//  Login.swift
//  CabRider
//
//  Created by Anurag on 25/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let login = try Login(json)

import Foundation

class Login: Codable {
    let success: Bool
    let type, text: String
    let data: LoginData
    
    init(success: Bool, type: String, text: String, data: LoginData) {
        self.success = success
        self.type = type
        self.text = text
        self.data = data
    }
}

class LoginData: Codable {
    let accesssToken, currencyCode, currencySymbol: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case accesssToken = "accesss_token"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case user
    }
    
    init(accesssToken: String, currencyCode: String, currencySymbol: String, user: User) {
        self.accesssToken = accesssToken
        self.currencyCode = currencyCode
        self.currencySymbol = currencySymbol
        self.user = user
    }
}

class User: Codable {
    let id: Int
    let fname, lname, email: String
    let isEmailVerified: Int
    let countryCode, mobileNumber, fullMobileNumber: String
    let isMobileNumberVerified: Int
    let status, lastAccessTime, lastAccessedIP, rating: String
    let timezone, createdAt, updatedAt: String
    let deletedAt: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id, fname, lname, email
        case isEmailVerified = "is_email_verified"
        case countryCode = "country_code"
        case mobileNumber = "mobile_number"
        case fullMobileNumber = "full_mobile_number"
        case isMobileNumberVerified = "is_mobile_number_verified"
        case status
        case lastAccessTime = "last_access_time"
        case lastAccessedIP = "last_accessed_ip"
        case rating, timezone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
    
    init(id: Int, fname: String, lname: String, email: String, isEmailVerified: Int, countryCode: String, mobileNumber: String, fullMobileNumber: String, isMobileNumberVerified: Int, status: String, lastAccessTime: String, lastAccessedIP: String, rating: String, timezone: String, createdAt: String, updatedAt: String, deletedAt: JSONNull?) {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.countryCode = countryCode
        self.mobileNumber = mobileNumber
        self.fullMobileNumber = fullMobileNumber
        self.isMobileNumberVerified = isMobileNumberVerified
        self.status = status
        self.lastAccessTime = lastAccessTime
        self.lastAccessedIP = lastAccessedIP
        self.rating = rating
        self.timezone = timezone
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

// MARK: Convenience initializers

extension Login {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Login.self, from: data)
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

extension LoginData {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(LoginData.self, from: data)
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

extension User {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(User.self, from: data)
        self.init(id: me.id, fname: me.fname, lname: me.lname, email: me.email, isEmailVerified: me.isEmailVerified, countryCode: me.countryCode, mobileNumber: me.mobileNumber, fullMobileNumber: me.fullMobileNumber, isMobileNumberVerified: me.isMobileNumberVerified, status: me.status, lastAccessTime: me.lastAccessTime, lastAccessedIP: me.lastAccessedIP, rating: me.rating, timezone: me.timezone, createdAt: me.createdAt, updatedAt: me.updatedAt, deletedAt: me.deletedAt)
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

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

