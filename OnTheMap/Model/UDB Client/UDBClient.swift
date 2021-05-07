//
//  UDBClient.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import Foundation
import UIKit
import MapKit

class UDBCLient {
    
    static var shared = UDBCLient()
        var firstName = ""
        var lastName = ""
    
    enum Endpoints {
        static let baseUrl = "https://onthemap-api.udacity.com/v1"
        
        struct Auth {
            static var accountKey = ""
        }
        
        
        case getStudentLocation
        case login
        
        var urlString: String {
            switch self {
            
            case .getStudentLocation:
                return Endpoints.baseUrl + "/StudentLocation?limit=100&order=-updatedAt"
            case .login:
                return Endpoints.baseUrl + "/session"
            }
        }
        
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, removeFirstCharacters: Bool, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let studentData = data
            
            print(String(data: studentData, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: studentData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
        return task
        
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL,removeFirstCharacters: Bool, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            var studentData = data
            if removeFirstCharacters {
                let range = 5..<data.count
                studentData = studentData.subdata(in: range) /* subset response data! */
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let responseObject = try decoder.decode(PostLocationResponse.self, from: studentData)
                DispatchQueue.main.async {
                    completion((responseObject as! ResponseType), nil)
                }
            } catch {
                completion(nil, ErrorMessage(message: error.localizedDescription ))
            }
        }
        task.resume()
    }

    
    class func login(email: String, password: String, completion: @escaping (Bool, Error?) -> ()) {
        
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        print(request)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = (5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(LoginResponse.self, from: newData)
                let accountId = decoded.account.key
                
                self.Endpoints.Auth.accountKey = accountId!
                print("Account Key is \(String(describing: accountId))")
                completion(true, nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(false, nil)
            }
        }
        task.resume()
        
        
    }
    
    
}
