//
//  RideHistory.swift
//  CabRider
//
//  Created by Anurag on 18/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import Alamofire

class RideHistory: Codable {
    let success: Bool
    let type, text: String
    let data: RideHistoryData
    
    init(success: Bool, type: String, text: String, data: RideHistoryData) {
        self.success = success
        self.type = type
        self.text = text
        self.data = data
    }
}

class RideHistoryData: Codable {
    let rideRequests: [RideRequest]
    let paging: Paging
    
    enum CodingKeys: String, CodingKey {
        case rideRequests = "ride_requests"
        case paging
    }
    
    init(rideRequests: [RideRequest], paging: Paging) {
        self.rideRequests = rideRequests
        self.paging = paging
    }
}

class Paging: Codable {
    let total: Int
    let hasMore: Bool
    let nextPageURL: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case hasMore = "has_more"
        case nextPageURL = "next_page_url"
        case count
    }
    
    init(total: Int, hasMore: Bool, nextPageURL: String, count: Int) {
        self.total = total
        self.hasMore = hasMore
        self.nextPageURL = nextPageURL
        self.count = count
    }
}

class RideRequest: Codable {
    let id, userID, driverID: Int
    let rideVehicleType: VehicleType
    let sourceAddress, sourceLatitude, sourceLongitude, destinationAddress: String
    let destinationLatitude, destinationLongitude: String
    let rideDistance: RideDistance
    let rideTime: Int
    let estimatedFare: EstimatedFare
    let rideStartTime, rideEndTime: String?
    let rideStatus: RideStatus
    let paymentMode: PaymentMode
    let paymentStatus: RideRequestPaymentStatus
    let rideInvoiceID, userRating, driverRating: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let driver: Driver
    let invoice: Invoice?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case driverID = "driver_id"
        case rideVehicleType = "ride_vehicle_type"
        case sourceAddress = "source_address"
        case sourceLatitude = "source_latitude"
        case sourceLongitude = "source_longitude"
        case destinationAddress = "destination_address"
        case destinationLatitude = "destination_latitude"
        case destinationLongitude = "destination_longitude"
        case rideDistance = "ride_distance"
        case rideTime = "ride_time"
        case estimatedFare = "estimated_fare"
        case rideStartTime = "ride_start_time"
        case rideEndTime = "ride_end_time"
        case rideStatus = "ride_status"
        case paymentMode = "payment_mode"
        case paymentStatus = "payment_status"
        case rideInvoiceID = "ride_invoice_id"
        case userRating = "user_rating"
        case driverRating = "driver_rating"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case driver, invoice
    }
    
    init(id: Int, userID: Int, driverID: Int, rideVehicleType: VehicleType, sourceAddress: String, sourceLatitude: String, sourceLongitude: String, destinationAddress: String, destinationLatitude: String, destinationLongitude: String, rideDistance: RideDistance, rideTime: Int, estimatedFare: EstimatedFare, rideStartTime: String?, rideEndTime: String?, rideStatus: RideStatus, paymentMode: PaymentMode, paymentStatus: RideRequestPaymentStatus, rideInvoiceID: Int, userRating: Int, driverRating: Int, createdAt: String, updatedAt: String, deletedAt: String?, driver: Driver, invoice: Invoice?) {
        self.id = id
        self.userID = userID
        self.driverID = driverID
        self.rideVehicleType = rideVehicleType
        self.sourceAddress = sourceAddress
        self.sourceLatitude = sourceLatitude
        self.sourceLongitude = sourceLongitude
        self.destinationAddress = destinationAddress
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.rideDistance = rideDistance
        self.rideTime = rideTime
        self.estimatedFare = estimatedFare
        self.rideStartTime = rideStartTime
        self.rideEndTime = rideEndTime
        self.rideStatus = rideStatus
        self.paymentMode = paymentMode
        self.paymentStatus = paymentStatus
        self.rideInvoiceID = rideInvoiceID
        self.userRating = userRating
        self.driverRating = driverRating
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.driver = driver
        self.invoice = invoice
    }
}

class Driver: Codable {
    let id: Int
    let fname: Fname
    let lname: Lname
    let email: Email
    let isEmailVerified: Int
    let countryCode: CountryCode
    let mobileNumber: MobileNumber
    let fullMobileNumber: FullMobileNumber
    let isMobileNumberVerified: Int
    let status: Status
    let statusReason: StatusReason
    let isAvailable, isConnectedToSocket: Int
    let rating: Rating
    let lastAccessTime: String
    let lastAccessedIP: LastAccessedIP
    let vehicleType: VehicleType
    let vehicleNumber: VehicleNumber
    let latitude: Latitude
    let longitude: Longitude
    let isApproved: Int
    let timezone: Timezone
    let createdAt, updatedAt: String
    let deletedAt: String?
    let profilePhotoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, fname, lname, email
        case isEmailVerified = "is_email_verified"
        case countryCode = "country_code"
        case mobileNumber = "mobile_number"
        case fullMobileNumber = "full_mobile_number"
        case isMobileNumberVerified = "is_mobile_number_verified"
        case status
        case statusReason = "status_reason"
        case isAvailable = "is_available"
        case isConnectedToSocket = "is_connected_to_socket"
        case rating
        case lastAccessTime = "last_access_time"
        case lastAccessedIP = "last_accessed_ip"
        case vehicleType = "vehicle_type"
        case vehicleNumber = "vehicle_number"
        case latitude, longitude
        case isApproved = "is_approved"
        case timezone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case profilePhotoURL = "profile_photo_url"
    }
    
    init(id: Int, fname: Fname, lname: Lname, email: Email, isEmailVerified: Int, countryCode: CountryCode, mobileNumber: MobileNumber, fullMobileNumber: FullMobileNumber, isMobileNumberVerified: Int, status: Status, statusReason: StatusReason, isAvailable: Int, isConnectedToSocket: Int, rating: Rating, lastAccessTime: String, lastAccessedIP: LastAccessedIP, vehicleType: VehicleType, vehicleNumber: VehicleNumber, latitude: Latitude, longitude: Longitude, isApproved: Int, timezone: Timezone, createdAt: String, updatedAt: String, deletedAt: String?, profilePhotoURL: String) {
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
        self.statusReason = statusReason
        self.isAvailable = isAvailable
        self.isConnectedToSocket = isConnectedToSocket
        self.rating = rating
        self.lastAccessTime = lastAccessTime
        self.lastAccessedIP = lastAccessedIP
        self.vehicleType = vehicleType
        self.vehicleNumber = vehicleNumber
        self.latitude = latitude
        self.longitude = longitude
        self.isApproved = isApproved
        self.timezone = timezone
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.profilePhotoURL = profilePhotoURL
    }
}

enum CountryCode: String, Codable {
    case the91 = "+91"
}

enum Email: String, Codable {
    case johndoeGmailCOM = "johndoe@gmail.com"
    case rooneyGmailCOM = "rooney@gmail.com"
}

enum Fname: String, Codable {
    case john = "John"
    case rooney = "Rooney"
}

enum FullMobileNumber: String, Codable {
    case the918904817810 = "+918904817810"
    case the919739560640 = "+919739560640"
}

enum LastAccessedIP: String, Codable {
    case the2759127110 = "27.59.127.110"
}

enum Latitude: String, Codable {
    case the129552232 = "12.9552232"
    case the129552497 = "12.9552497"
}

enum Lname: String, Codable {
    case doe = "Doe"
    case wayne = "Wayne"
}

enum Longitude: String, Codable {
    case the776545542 = "77.6545542"
    case the776546250 = "77.6546250"
}

enum MobileNumber: String, Codable {
    case the8904817810 = "8904817810"
    case the9739560640 = "9739560640"
}

enum Rating: String, Codable {
    case the49 = "4.9"
    case the50 = "5.0"
}

enum Status: String, Codable {
    case activated = "ACTIVATED"
}

enum StatusReason: String, Codable {
    case empty = ""
}

enum Timezone: String, Codable {
    case asiaKolkata = "Asia/Kolkata"
}

enum VehicleNumber: String, Codable {
    case vb67Hhj = "VB67HHJ"
    case wu688Yru = "WU688YRU"
}

enum VehicleType: String, Codable {
    case sedan = "SEDAN"
}

enum EstimatedFare: String, Codable {
    case the15600 = "156.00"
    case the15700 = "157.00"
    case the16700 = "167.00"
    case the17800 = "178.00"
    case the20300 = "203.00"
}

class Invoice: Codable {
    let id: Int
    let invoiceReference: String
    let paymentMode: PaymentMode
    let paymentStatus: InvoicePaymentStatus
    let transactionTableID: Int
    let currencyType: CurrencyType
    let rideFare: String
    let accessFee: AccessFee
    let tax: String
    let total: Total
    let createdAt, updatedAt: String
    let deletedAt: String?
    let mapURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case invoiceReference = "invoice_reference"
        case paymentMode = "payment_mode"
        case paymentStatus = "payment_status"
        case transactionTableID = "transaction_table_id"
        case currencyType = "currency_type"
        case rideFare = "ride_fare"
        case accessFee = "access_fee"
        case tax, total
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case mapURL = "map_url"
    }
    
    init(id: Int, invoiceReference: String, paymentMode: PaymentMode, paymentStatus: InvoicePaymentStatus, transactionTableID: Int, currencyType: CurrencyType, rideFare: String, accessFee: AccessFee, tax: String, total: Total, createdAt: String, updatedAt: String, deletedAt: String?, mapURL: String) {
        self.id = id
        self.invoiceReference = invoiceReference
        self.paymentMode = paymentMode
        self.paymentStatus = paymentStatus
        self.transactionTableID = transactionTableID
        self.currencyType = currencyType
        self.rideFare = rideFare
        self.accessFee = accessFee
        self.tax = tax
        self.total = total
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.mapURL = mapURL
    }
}

enum AccessFee: String, Codable {
    case the10000 = "100.00"
}

enum CurrencyType: String, Codable {
    case inr = "INR"
}

enum PaymentMode: String, Codable {
    case cash = "CASH"
    case online = "ONLINE"
}

enum InvoicePaymentStatus: String, Codable {
    case paid = "PAID"
}

enum Total: String, Codable {
    case the15600 = "156.00"
    case the16700 = "167.00"
    case the17800 = "178.00"
    case the20300 = "203.00"
}

enum RideRequestPaymentStatus: String, Codable {
    case notPaid = "NOT_PAID"
    case paid = "PAID"
}

enum RideDistance: String, Codable {
    case the00 = "0.0"
    case the55 = "5.5"
}

enum RideStatus: String, Codable {
    case completed = "COMPLETED"
    case driverCanceled = "DRIVER_CANCELED"
    case userCanceled = "USER_CANCELED"
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseRideHistory(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<RideHistory>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: Convenience initializers

extension RideHistory {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(RideHistory.self, from: data)
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

extension RideHistoryData {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(RideHistoryData.self, from: data)
        self.init(rideRequests: me.rideRequests, paging: me.paging)
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

extension Paging {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Paging.self, from: data)
        self.init(total: me.total, hasMore: me.hasMore, nextPageURL: me.nextPageURL, count: me.count)
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

extension RideRequest {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(RideRequest.self, from: data)
        self.init(id: me.id, userID: me.userID, driverID: me.driverID, rideVehicleType: me.rideVehicleType, sourceAddress: me.sourceAddress, sourceLatitude: me.sourceLatitude, sourceLongitude: me.sourceLongitude, destinationAddress: me.destinationAddress, destinationLatitude: me.destinationLatitude, destinationLongitude: me.destinationLongitude, rideDistance: me.rideDistance, rideTime: me.rideTime, estimatedFare: me.estimatedFare, rideStartTime: me.rideStartTime, rideEndTime: me.rideEndTime, rideStatus: me.rideStatus, paymentMode: me.paymentMode, paymentStatus: me.paymentStatus, rideInvoiceID: me.rideInvoiceID, userRating: me.userRating, driverRating: me.driverRating, createdAt: me.createdAt, updatedAt: me.updatedAt, deletedAt: me.deletedAt, driver: me.driver, invoice: me.invoice)
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

extension Driver {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Driver.self, from: data)
        self.init(id: me.id, fname: me.fname, lname: me.lname, email: me.email, isEmailVerified: me.isEmailVerified, countryCode: me.countryCode, mobileNumber: me.mobileNumber, fullMobileNumber: me.fullMobileNumber, isMobileNumberVerified: me.isMobileNumberVerified, status: me.status, statusReason: me.statusReason, isAvailable: me.isAvailable, isConnectedToSocket: me.isConnectedToSocket, rating: me.rating, lastAccessTime: me.lastAccessTime, lastAccessedIP: me.lastAccessedIP, vehicleType: me.vehicleType, vehicleNumber: me.vehicleNumber, latitude: me.latitude, longitude: me.longitude, isApproved: me.isApproved, timezone: me.timezone, createdAt: me.createdAt, updatedAt: me.updatedAt, deletedAt: me.deletedAt, profilePhotoURL: me.profilePhotoURL)
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

extension Invoice {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Invoice.self, from: data)
        self.init(id: me.id, invoiceReference: me.invoiceReference, paymentMode: me.paymentMode, paymentStatus: me.paymentStatus, transactionTableID: me.transactionTableID, currencyType: me.currencyType, rideFare: me.rideFare, accessFee: me.accessFee, tax: me.tax, total: me.total, createdAt: me.createdAt, updatedAt: me.updatedAt, deletedAt: me.deletedAt, mapURL: me.mapURL)
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


