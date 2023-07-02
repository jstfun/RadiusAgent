//
//  FacilitiesResponse.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

struct ExclusionOption: Codable {
    let facilityId: String
    let optionsId: String
}

struct GetFacilitiesResponse: Codable {
    let facilities: [FacilityEntity]
    let exclusions: [[ExclusionOption]]
}
