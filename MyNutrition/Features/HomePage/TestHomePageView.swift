//
//  TestHomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 23/12/2024.
//

import SwiftUI

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        Text("Home page view test!")
        Button {
            Task {
                do {
                    await viewModel.logout()
                }
            }
            
        } label: {
            Text("Sign Out")
        }

    }
}

