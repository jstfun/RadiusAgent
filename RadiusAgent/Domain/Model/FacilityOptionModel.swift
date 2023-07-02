//
//  FacilityOptionModel.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

struct FacilityOptionModel {
    let id: String
    let name: String
    let icon: String
    var enabled: Bool
}

extension FacilityOptionModel {
    init(from entity: FacilityOptionEntity) {
        id = entity.id
        name = entity.name
        icon = entity.icon
        enabled = true
    }
    
    static var example: Self {
        FacilityOptionModel(id: "1", name: "Apartment", icon: "apartment", enabled: true)
    }
}
