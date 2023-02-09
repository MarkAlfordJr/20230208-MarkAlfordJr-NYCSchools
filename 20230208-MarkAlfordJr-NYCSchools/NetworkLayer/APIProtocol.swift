//
//  Endpoints.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import Foundation

// provide the HTTP methods, in order to customize any API
enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

// provide the HTTP schemes, for the url being secure or not
enum HTTPScheme: String {
    case http
    case https
}

/*
 purpose: provide template for all APIs to inherit. provides
 customization for any url, with EVERY different api being its own
 enum
 
 ex.
 - SchoolAPI enum
 - SATScoresAPI enum
 */
protocol API {
    // http or https
    var scheme: HTTPScheme { get }
    // Example: "maps.googleapis.com"
    var baseURL: String { get }
    // "/maps/api/place/nearbysearch/"
    var path: String { get }
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }
    // "GET"
    var method: HTTPMethod { get }
}
