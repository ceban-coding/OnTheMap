//
//  StudentLocationResults.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/4/21.
//

import Foundation

struct StudentLoctaionResults: Codable {
    let studentLocations: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case studentLocations = "results"
    }
}
