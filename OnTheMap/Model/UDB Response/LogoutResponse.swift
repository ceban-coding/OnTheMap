//
//  LogoutResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/13/21.
//

import Foundation

struct LogoutResponse: Codable {
    
    let session: LogoutSession
}

struct LogoutSession: Codable {
    let id: String
    let expiration: String
}
