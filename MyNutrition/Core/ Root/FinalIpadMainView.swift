//
//  FinalPresentationContentVIew.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI

struct FinalIpadMainView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewModel: BaseAuthViewModel
    var body: some View {
        IPadSplitView(viewModel: viewModel, authService: authService, nutritionService: nutritionService)
    }
}

