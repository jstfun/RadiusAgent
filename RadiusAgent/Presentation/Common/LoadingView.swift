//
//  LoadingView.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import SwiftUI

struct LoadingView: View {
    var tintColor: Color = .gray
    var scaleSize: CGFloat = 1
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
