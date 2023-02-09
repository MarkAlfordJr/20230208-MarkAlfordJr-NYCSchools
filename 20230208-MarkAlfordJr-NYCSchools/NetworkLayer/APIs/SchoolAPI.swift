//
//  SchoolAPI.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import Foundation

// https://data.cityofnewyork.us/resource/s3k6-pzi2.json
enum SchoolAPI: API {
    case getschools
    
    var scheme: HTTPScheme {
        switch self {
        case .getschools:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getschools:
            return "data.cityofnewyork.us"
        }
    }
    
    var path: String {
        switch self {
        case .getschools:
            return "/resource/s3k6-pzi2.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getschools:
            return []
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getschools:
            return .get
        }
    }
}
