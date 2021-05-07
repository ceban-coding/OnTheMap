//
//  UdacityLoginResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/5/21.
//

import Foundation

struct udacityLoginResponse: Codable {
    let account: UdacityAccount
    let session: UdacitySession
    
    enum CodingKeys: String, CodingKey {
        case account = "account"
        case session = "session"
    }
}

struct UdacityAccount: Codable {
    let registered: Bool
    let key: String
}

struct UdacitySession: Codable {
    let id: String
    let expiration: String
}
