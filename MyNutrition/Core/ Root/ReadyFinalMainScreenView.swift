//
//  ReadyFinalMainScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI

struct ReadyFinalMainScreenView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewModel: BaseAuthViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        if sizeClass == .compact {
            FinalIphoneMainView(authService: _authService, viewModel: _viewModel)
                .padding()
        } else {
            FinalIpadMainView()
                .padding()
        }
    }
}

#Preview {
    ReadyFinalMainScreenView()
}
