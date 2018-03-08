//
//  VehicleTypes.swift
//  CabRider
//
//  Created by Anurag on 06/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//
import Foundation
import Alamofire

class VehicleTypes: Codable {
    let success: Bool
    let type, text: String
    let data: VehicleTypesData
    
    init(success: Bool, type: String, text: String, data: VehicleTypesData) {
        self.success = success
        self.type = type
        self.text = text
        self.data = data
    }
}

public class VehicleTypesData: Codable {
    let vtypes: [Vtype]
    
    init(vtypes: [Vtype]) {
        self.vtypes = vtypes
    }
}

public class Vtype: Codable {
    let id: Int
    let code, name: String
    let createdAt, updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, code, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
    
    init(id: Int, code: String, name: String, createdAt: String?, updatedAt: String?, deletedAt: String?) {
        self.id = id
        self.code = code
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

// MARK: Alamofire response handlers -

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
    func responseVehicleTypes(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<VehicleTypes>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: Convenience initializers

extension VehicleTypes {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(VehicleTypes.self, from: data)
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

extension VehicleTypesData {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(VehicleTypesData.self, from: data)
        self.init(vtypes: me.vtypes)
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

extension Vtype {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Vtype.self, from: data)
        self.init(id: me.id, code: me.code, name: me.name, createdAt: me.createdAt, updatedAt: me.updatedAt, deletedAt: me.deletedAt)
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


