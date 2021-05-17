//
//  UDBClient.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import Foundation
import UIKit
import MapKit
import Reachability

class UDBClient {
 
    
    //MARK: - Endpoints
    
    enum Endpoints {
        static let baseUrl = "https://onthemap-api.udacity.com/v1"
        
        struct Auth {
            static var accountKey = ""
            static var firstName = ""
            static var lastName = ""
        }
        
        case login
        case getStudentLocation
        case postStudentLocation
        case logOut
        case getUserData
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.baseUrl + "/session"
            case .getStudentLocation:
                return Endpoints.baseUrl + "/StudentLocation?limit=100&order=-updatedAt"
            case .postStudentLocation:
                return Endpoints.baseUrl + "/StudentLocation"
            case .logOut:
                return Endpoints.baseUrl + "/session"
            case .getUserData:
                return Endpoints.baseUrl + "/users/" + Auth.accountKey
            }
        }
        
        var url: URL {
            URL(string: self.stringValue)!
        }
    }
    
    //MARK: Errors
    enum Errors {
        
        case networkFailed
        case incorrectLoginDetails
        
        var nsError: NSError {
            switch self {
            case .networkFailed : return NSError(domain: "Network Error", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Failed to communicate with Udacity. Check your network connection."])
            case .incorrectLoginDetails : return NSError(domain: "Login Failed", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Incorrect username and/or password. Please try again."])
            }
        }
    }
    
    //MARK: - Get Request
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, removeFirstCharacters: Bool, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            var newData = data
            
            if removeFirstCharacters {
                let range = 5..<data.count
                newData = newData.subdata(in: range) /* subset response data! */
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
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
    
    //Mark: - Post Request
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, removeFirstCharacters: Bool, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            var newData = data
            if removeFirstCharacters {
                let range = 5..<data.count
                newData = newData.subdata(in: range) /* subset response data! */
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion((responseObject ), nil)
                }
            } catch {
                completion(nil, ErrorMessage(message: error.localizedDescription ))
            }
        }
        task.resume()
    }
    
    //MARK: - Delete Request
    
    class func taskForDELETERequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (Bool, Error?) -> Void) -> URLSessionTask {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                _ = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, ErrorMessage(message: "Logout has failed. Try again."))
                }
            }
        }
        task.resume()
        
        return task
    }
   
    
    //MARK: - Login Post Request
   
    class func login(email: String, password: String, completion: @escaping (Bool, Error?) -> ()) {
        
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        print(request)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if  error != nil {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                print(error?.localizedDescription ?? "")
                return
            }

            guard let data = data else {
                return
            }

            let range = (5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            
            let decoder = JSONDecoder()
            do {
        
                let decoded = try decoder.decode(LoginResponse.self, from: newData)
                let accountId = decoded.account.key
                DispatchQueue.main.async {
                    self.Endpoints.Auth.accountKey = accountId!
                    print("Account Key is \(String(describing: accountId))")
                    completion(true, nil)
                }
                

            } catch  {
                let incorrectLoginError = Errors.incorrectLoginDetails.nsError
                DispatchQueue.main.async {
                    completion(false, incorrectLoginError)
                }
                
            }
        }
        task.resume()
      
        
    }
    
    //MARK: - Get Student Location Request
    
    class func getStudentLocation(completion: @escaping ([StudentLocation], Error?) -> Void) {
        
        let _ = taskForGETRequest(url: Endpoints.getStudentLocation.url, removeFirstCharacters: false, response: StudentLocationResults.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], ErrorMessage(message: "There was an error. Try again."))
            }
        }
    }
    
    //MARK: - Post request
    
    class func postStudentLocation(firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Float, longitude: Float, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: Endpoints.postStudentLocation.url, removeFirstCharacters: false, responseType: PostLocationResponse.self, body: PostLocationRequest(uniqueKey: Endpoints.Auth.accountKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)) { (_, error) in
                completion(error == nil, error)
            }
        }
    
    
    //MARK: -Logout Request
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        let _ = taskForDELETERequest(url: Endpoints.logOut.url, response: LogoutResponse.self) { (response, error) in
            completion(response, error)
        }
    }
    
    //MARK: - User Data Get Request
    
    class func getPublicUserData(completion: @escaping (String?, String?, Error?) -> Void) {
        let _ = taskForGETRequest(url: Endpoints.getUserData.url, removeFirstCharacters: true, response: UserResponse.self) { (response, error) in
            if let response = response {
                completion(response.firstName, response.lastName, nil)
            } else {
                completion(nil, nil, error)
            }
        }
    }
    
    //MARK: - LogOut get request
    
    class func getLoggedInUsserProfile(completion: @ escaping (Bool, Error?) -> Void) {
        let _ = taskForGETRequest(url: Endpoints.getUserData.url, removeFirstCharacters: true, response: UserResponse.self) { response, error in
            if let response = response {
                Endpoints.Auth.firstName = response.firstName
                Endpoints.Auth.lastName = response.lastName
                completion (true, nil)
            } else {
                print("Failed to get user's profile")
                completion (false, error)
            }
        }
    }
    
    
   
}




