//
//  FacilityListView.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import SwiftUI

struct FacilityListView: View {
    @StateObject var viewModel = FacilityListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.showLoading {
                    LoadingView(scaleSize: 1.6)
                } else {
                    facilityListView
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                alertView
            }
            .navigationTitle(viewModel.navigationTitle)
            .refreshable {
                fetchData()
            }
        }.onAppear {
            fetchData()
        }
    }
    
    var facilityListView: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                ForEach(viewModel.facilities, id: \.id) { facility in
                    Section(header: FacilitySectionView(title: facility.name)) {
                        ForEach(facility.options, id: \.id) { option in
                            FacilityOptionView(option: option, isSelected: facility.selectedOptionId == option.id)
                                .onTapGesture {
                                    viewModel.handleOptionSelection(facilityId: facility.id, optionId: option.id)
                                }
                                .allowsHitTesting(option.enabled)
                        }
                    }
                }
            }
        }
    }
    
    var alertView: Alert {
        Alert(
            title: Text(viewModel.errorTitle),
            message: Text(viewModel.errorDescription),
            dismissButton: .default(Text(viewModel.errorButtonTitle), action: {})
        )
    }
    
    private func fetchData() {
        Task {
            await viewModel.fetchData()
        }
    }
}

struct FacilityListView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityListView()
    }
}
