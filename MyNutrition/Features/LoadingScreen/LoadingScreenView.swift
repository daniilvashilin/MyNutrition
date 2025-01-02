//
//  LoadingScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 23/12/2024.
//

import SwiftUI

struct LoadingScreenView: View {
    @State private var stepCount: Double = 0.0
    @State private var errorMessage: String?
    
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
