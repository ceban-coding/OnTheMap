//
//  PDBClient.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import Foundation

class PDBClient {
    
    static var currentLocations: [StudentLocation]?
    
    //MARK: Endpoints
    enum Endpoints {
        static let baseUrl: String = "https://onthemap-api.udacity.com/v1/StudentLocation"
        static let queryOrderUpdateTime: String = "order=-updatedAt"
        static let queryLimit: String = "limit=100"
        
        case getStudentLocation
        
        var stringValue: String {
            switch self {
            case .getStudentLocation:
                return Endpoints.baseUrl + "?" + Endpoints.queryLimit + "&" + Endpoints.queryOrderUpdateTime
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    

    //MARK: - get request
    
    class func taskForGetRequest(completion: @escaping ([StudentLocation]?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: Endpoints.getStudentLocation.url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLoctaionResults.self, from: data)
                let studentLocation = responseObject.studentLocations
                DispatchQueue.main.async {
                    self.currentLocations = studentLocation
                    completion(studentLocation, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                    }
                }
            }

        task.resume()
}


//MARK: - POST a student

    class func postStudentLocation(studentLocation: StudentLocation, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.getStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = studentLocation.daata( using.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
