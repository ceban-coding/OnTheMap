//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/13/21.
//

import Foundation

struct ErrorResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum Codingkeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        
    }    
}
