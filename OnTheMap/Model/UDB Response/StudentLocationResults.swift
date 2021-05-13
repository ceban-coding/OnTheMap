//
//  File.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/12/21.
//

import Foundation

struct StudentLocationResults: Codable {
    
    let results: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case results 
    }
}
