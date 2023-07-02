//
//  FacilityUseCase.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

class FacilityUseCase {
    private let apiService: APIService
    private var facilityStore: FacilityStore?
    
    var facilities: [FacilityModel] {
        facilityStore?.facilities ?? []
    }
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    /// Load facilities from data provider, currently fetched the data from remote server via REST APi only.
    /// A facility store is created with data and indices.
    func loadFacilities() async throws -> [FacilityModel] {
        let response = await apiService.getFacilities()
        let data = try response.get()
        facilityStore = FacilityStore(entities: data.facilities, exclusions: data.exclusions)
        return facilities
    }
    
    func selecteOption(facilityId: String, optionId: String) {
        facilityStore?.updateSelectedOption(facilityId: facilityId, optionId: optionId)
    }
}
