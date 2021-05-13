//
//  ErrorMessage.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/13/21.
//

import Foundation

struct ErrorMessage {
    let message: String
    
}

extension ErrorMessage: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
