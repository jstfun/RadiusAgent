//
//  FacilityOptionView.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import SwiftUI

struct FacilityOptionView: View {
    let option: FacilityOptionModel
    let isSelected: Bool
    
    var body: some View {
        HStack() {
            Image(option.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32)
                .colorMultiply(option.enabled ? .white : .secondary)
            
            Text(option.name)
                .foregroundColor(option.enabled ? .black : .secondary)
            
            Spacer()
            
            if option.enabled {
                selectionImageView
            }
        }
        .padding()
    }
    
    var selectionImageView: some View {
        let imagName = isSelected ? "checkmark.circle.fill" : "circle"
        return Image(systemName: imagName)
            .resizable()
            .scaledToFit()
            .frame(width: 20)
            .foregroundColor(.blue)
            .padding()
            
    }
}

struct FacilityOptionView_Previews: PreviewProvider {
    static var previews: some View {
        
        FacilityOptionView(option: FacilityOptionModel.example, isSelected: true)
    }
}
