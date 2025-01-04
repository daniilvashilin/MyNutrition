//
//  FinalLoginScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 18/12/2024.
//

import SwiftUI

struct FinalLoginScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel = BaseAuthViewModel()
    @EnvironmentObject var authService: AuthService
      var body: some View {
          if sizeClass == .compact {
              IPhoneScreenView(viewModel: viewModel, authService: authService)
                  .ignoresSafeArea(.keyboard, edges: .bottom)
              autocorrectionDisabled() 
          } else if sizeClass == .regular {
              IPadScreenView(viewModel: viewModel, authService: authService)
                  .ignoresSafeArea(.keyboard, edges: .bottom)
              autocorrectionDisabled()
          }
      }
  }


