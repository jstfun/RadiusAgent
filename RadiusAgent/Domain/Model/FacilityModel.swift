//
//  FacilityModel.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

struct FacilityModel {
    let id: String
    let name: String
    var options: [FacilityOptionModel]
    var selectedOptionId: String?
}

extension FacilityModel {
    init(from entity: FacilityEntity) {
        id = entity.id
        name = entity.name
        options = entity.options.map { FacilityOptionModel(from: $0) }
    }
}
