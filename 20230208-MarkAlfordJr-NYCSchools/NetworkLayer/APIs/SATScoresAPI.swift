//
//  SATScoresAPI.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import Foundation

// https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=11X253
enum SATScoresAPI: API {
    case getSatScore(dbn: String)
    
    var scheme: HTTPScheme {
        switch self {
        case .getSatScore:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getSatScore:
            return "data.cityofnewyork.us"
        }
    }
    
    var path: String {
        switch self {
        case .getSatScore:
            return "/resource/f9bf-2cp4.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getSatScore(let schooldbn):
            let params = [
                URLQueryItem(name: "dbn", value: schooldbn)
            ]
            return params
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSatScore:
            return .get
        }
    }
}
