//
//  SchoolResponseModel.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import Foundation

struct SchoolResponseModel: Codable {
    let dbn, schoolName, location, phoneNumber, neighborhood: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case location = "location"
        case phoneNumber = "phone_number"
        case neighborhood = "neighborhood"
    }
}

typealias SchoolResponseModelArray = [SchoolResponseModel]
