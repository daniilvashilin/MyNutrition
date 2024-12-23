//
//  LoadingScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 23/12/2024.
//

import SwiftUI

struct LoadingScreenView: View {
    var body: some View {
        VStack {
            Text("Loading Screen View!")
                .font(.largeTitle)
            Image(systemName: "circle.dashed")
                .font(.title)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    LoadingScreenView()
}
