//
//  FacilityEntity.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

struct FacilityEntity: Codable {
    let id: String
    let name: String
    let options: [FacilityOptionEntity]
    
    enum CodingKeys: String, CodingKey {
        case id = "facilityId"
        case name, options
    }
}
