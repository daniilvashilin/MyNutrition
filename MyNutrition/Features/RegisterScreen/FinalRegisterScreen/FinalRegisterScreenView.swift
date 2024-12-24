//
//  FinalRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct FinalRegisterScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel = BaseAuthViewModel()
    var body: some View {
        if sizeClass == .compact {
            IPhoneRegisterScreenView()
        } else if sizeClass == .regular {
            IPadRegisterScreenView()
        }
    }
}

#Preview {
    FinalRegisterScreenView()
}
