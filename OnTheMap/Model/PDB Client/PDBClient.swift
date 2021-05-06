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
        static let queryUpdate: String = "order=-updatedAt"
        static let queryLimit: String = "limit=100"
        
        case getStudentLocation
        
        var stringValue: String {
            switch self {
            case .getStudentLocation:
                return Endpoints.baseUrl + "?" + Endpoints.queryLimit + "&" + Endpoints.queryUpdate
                
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
                let studentLocation = responseObject.studentLocation
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


//MARK: - POST Request

    class func postStudentLocation(studentLocation: StudentLocation, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.getStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil {
            DispatchQueue.main.async {
                completion(error)
            }
              return
          } else {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
        task.resume()
    }
}
