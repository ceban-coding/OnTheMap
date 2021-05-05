//
//  UdacityResponseError.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/5/21.
//

import Foundation

struct UdacityErrorResponse: Codable, Error {
    let status: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case message = "error"
    }
}
