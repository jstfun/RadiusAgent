//
//  FacilityStore.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation
import OrderedCollections

/// A data store containing facility data and indices,
/// used as a data provider and index store for efficient data searching.
class FacilityStore {
    /// Dictionary containing facility data, with the facility ID as the key
    private var _facilities: OrderedDictionary<String,FacilityModel> = [:]
    /// Diciontary containing the index of options array in the facility, with the "FacilityID-OptionID" as the key
    private var optionsIndex: [String: Int] = [:]
    /// Dictionary containing the exclusions in the format,
    /// - key: "FacilityID-OptionID",
    /// - value: array of the tuples (FacilityID, OptionID)
    private var exclusions: [String: [(String, String)]] = [:]
    
    var facilities: [FacilityModel] {
        Array(_facilities.values)
    }
    
    init(entities: [FacilityEntity], exclusions: [[ExclusionOption]]) {
        for entity in entities {
            let facility = FacilityModel(from: entity)
            _facilities[entity.id] = facility
            
            for (optionIndex, option) in facility.options.enumerated() {
                let key = "\(facility.id)-\(option.id)"
                optionsIndex[key] = optionIndex
            }
        }
        
        for exclusion in exclusions {
            guard let keyOption = exclusion.first else { continue }
            let excludeOptions = exclusion.dropFirst().map { ($0.facilityId, $0.optionsId) }
            let key = "\(keyOption.facilityId)-\(keyOption.optionsId)"
            self.exclusions[key] = Array(excludeOptions)
        }
    }
    
    func updateSelectedOption(facilityId: String, optionId: String) {
        resetEnabledOptions()
        toggleSelectedOption(facilityId: facilityId, optionId: optionId)
        applyExclusions()
    }
    
    private func resetEnabledOptions() {
        for facilityId in _facilities.keys {
            let options = _facilities[facilityId]?.options ?? []
            for j in 0..<options.count {
                _facilities[facilityId]?.options[j].enabled = true
            }
        }
    }
    
    private func toggleSelectedOption(facilityId: String, optionId: String) {
        guard let facility = _facilities[facilityId] else { return }
        let selected = (facility.selectedOptionId == optionId) ? nil : optionId
        _facilities[facilityId]?.selectedOptionId = selected
    }
    
    private func applyExclusions() {
        for facilityId in _facilities.keys {
            if let selectedId = _facilities[facilityId]?.selectedOptionId {
                let key = "\(facilityId)-\(selectedId)"
                if let exclusion = exclusions[key] {
                    for excludeOption in exclusion {
                        let fId = excludeOption.0
                        let oId = excludeOption.1
                        if let optionIndex = optionsIndex["\(fId)-\(oId)"] {
                            _facilities[fId]?.options[optionIndex].enabled = false
                        }
                    }
                }
            }
        }
    }
}
