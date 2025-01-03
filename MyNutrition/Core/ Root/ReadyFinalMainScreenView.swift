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
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        ZStack {
            Color.backGround
                .edgesIgnoringSafeArea(.all)
            if sizeClass == .compact {
                FinalIphoneMainView(authService: _authService, viewModel: _viewModel)
                    .padding()
            } else {
                FinalIpadMainView()
                    .padding()
            }
        }
        .onAppear {
            healthKitManager.requestHealthKitPermissions()
            healthKitManager.fetchStepsData()
            healthKitManager.fetchCaloriesBurnedData()
            healthKitManager.resetDailyDataIfNeeded()
        }
    }
}

