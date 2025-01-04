//
//  WelcomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI

struct WelcomePageView: View {
    @EnvironmentObject var viewModel: BaseAuthViewModel
    @EnvironmentObject var authService: AuthService
    var body: some View {
        FinalLoginScreenView()
    }
}
