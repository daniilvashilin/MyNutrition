//
//  FinalLoginScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 18/12/2024.
//

import SwiftUI

struct FinalLoginScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
      var body: some View {
          if sizeClass == .compact {
              IPhoneScreenView()
          } else if sizeClass == .regular {
              IPadScreenView()
          }
      }
  }

#Preview {
    FinalLoginScreenView()
}
