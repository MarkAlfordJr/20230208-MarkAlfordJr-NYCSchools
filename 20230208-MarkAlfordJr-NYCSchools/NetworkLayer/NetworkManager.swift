//
//  NetworkManager.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import Foundation

final class NetworkManager {
    /*
     Builds the Relative URL Components from the values specified in
     the API
     */
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    /*
     Executes the HTTP request and will attempt to decode the JSON
     response into a Codable object.
     - Parameters:
     - endpoint: the endpoint to make the HTTP request to
     - completion: the JSON response converted to the provided Codable
     object when successful or a failure otherwise
     */
    class func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void) {
        
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else {
            print("URL creation error")
            return
        }
        // create the request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        // create the request session
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Unknown error", error)
                return
            }
            
            guard response != nil, let data = data else {
                return
            }
            DispatchQueue.main.async {
                // use a generic class, to allow different API enums to be decoded
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "",
                                        code: 200,
                                        userInfo: [
                                            NSLocalizedDescriptionKey: "Failed"
                                        ])
                    
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
