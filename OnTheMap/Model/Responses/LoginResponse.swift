//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/6/21.
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
