//
//  PDBResponses.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import Foundation

struct StudentLocation: Codable {
    
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let langitude: Double
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        
        case objectId = "objectId"
        case uniqueKey = "uniqueKey"
        case firstName = "firstName"
        case lastName = "lastName"
        case mapString = "mapString"
        case mediaURL = "mediaURL"
        case latitude = "latitude"
        case langitude = "langitude"
        case createdAt = "createdAT"
        case updatedAt = "updatedAT"
    }
}
