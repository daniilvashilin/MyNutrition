//
//  FinalRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct FinalRegisterScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var viewModel: BaseAuthViewModel
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authService: AuthService
    @EnvironmentObject var appState: AppState

    var body: some View {
        if sizeClass == .compact {
            IPhoneRegisterScreenView(authService: authService, viewModel: viewModel)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .autocorrectionDisabled()
        } else if sizeClass == .regular {
            IPadRegisterScreenView(authService: authService, viewModel: viewModel)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .autocorrectionDisabled()
        } else {
            Text("Unsupported device size")
                .foregroundColor(.red)
        }
    }
}
