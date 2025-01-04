//
//  WelcomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI

struct WelcomePageView: View {
    @State private var values = 1
    var body: some View {
        TabView {
            Tab("Celendar", image: "Celendar") {
                VStack {
                    SelectThemeView()
                }
            }
            
            Tab("Celendar", image: "Celendar") {
                VStack {
                    Text("New")
                }
            }
        }
        .tabViewStyle(.page)
    }
}


#Preview {
    WelcomePageView()
}
