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
      var body: some View {
          if sizeClass == .compact {
              IPhoneScreenView(viewModel: viewModel)
          } else if sizeClass == .regular {
              IPadScreenView(viewModel: viewModel)
          }
      }
  }

#Preview {
    FinalLoginScreenView()
}
