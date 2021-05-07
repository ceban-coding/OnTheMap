//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/6/21.
//

import Foundation

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
