//
//  FacilitySectionView.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import SwiftUI

struct FacilitySectionView: View {
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.white)
            .frame(height: 42)
            .overlay {
                HStack {
                    Text(title)
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
    }
}

struct FacilitySectionView_Previews: PreviewProvider {
    static var previews: some View {
        FacilitySectionView(title: "Section")
    }
}
