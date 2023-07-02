//
//  FacilityListViewModel.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

class FacilityListViewModel: ObservableObject {
    let navigationTitle = "Facilities"
    @Published var showLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var facilities: [FacilityModel] = []
    
    private let useCase: FacilityUseCase
    private(set) var errorTitle = ""
    private(set) var errorDescription = ""
    private(set) var errorButtonTitle = ""
    
    init(useCase: FacilityUseCase = FacilityUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchData() async {
        showLoading = true
        
        do {
            facilities = try await useCase.loadFacilities()
        } catch {
            showLoading.toggle()
            errorTitle = Constants.String.error
            errorDescription = Constants.String.failedFetchFacilities
            errorButtonTitle = Constants.String.ok
            showAlert = true
        }
        showLoading.toggle()
    }
    
    func handleOptionSelection(facilityId: String, optionId: String) {
        useCase.selecteOption(facilityId: facilityId, optionId: optionId)
        facilities = useCase.facilities
    }
}
