//
//  IPhoneRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct IPhoneRegisterScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var authService: AuthService
    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                ReadyRegisterScreenView(viewModel: viewModel, authService: authService, topTextFont: .title2, underTopTextFormFont: .footnote, showLogo: true)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
        }
    }
}

