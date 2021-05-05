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
    
    //EROORS
    enum Errors {
        
        case networkFailed
        case unableToDecode
        case unableToEncode
        
        var nsError: NSError {
            switch self {
            case .networkFailed : return NSError(domain: "Network Error", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Failed to communicate with Locations server. Check your network connection."])
            case .unableToDecode : return NSError(domain: "Error", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Unable to update locations. Please try again later"])
            case .unableToEncode : return NSError(domain: "Error", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Unable to generate your pin. Please try again"])
            }
        }
    }

    //MARK: - get request
    
    class func getStudentLocation(completion: @escaping ([StudentLocation]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { data, response, error in
            guard let data = data else {
                let networkError = Errors.networkFailed.nsError
                DispatchQueue.main.async {
                    completion(nil, networkError)
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
                let decodeError = Errors.unableToDecode.nsError
                DispatchQueue.main.async {
                    completion(nil, decodeError)
                    }
                }
            }

        task.resume()
}


//MARK: - POST a student

   //
   //class func postStudentLocation(completion: @escaping([StudentLocation]?, Error?) -> Void) {
        //var request = URLRequest(url: Endpoints.getStudentLocations.url)
       // let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url)
       // request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let session = URLSession.shared
        //let task = session.dataTask(with: request) { data, response, error in
          //if error != nil { // Handle error…
              //return
         // }
        //  print(String(data: data!, encoding: .utf8)!)
       // }
       // task.resume()
   // }

}
