//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/13/21.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
    
}

struct Account: Codable {
    let register: Bool?
    let key: String?
}

struct Session: Codable {
    let id: String?
    let expiraton: String?
}


struct PostLocationResponse: Codable {
    
    let createdAt: String?
    let objectId: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case objectId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        objectId = try container.decodeIfPresent(String.self, forKey: .objectId)
    }
    
}
