//
//  IPhoneScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI

struct IPhoneScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authService: AuthService
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                    ReadyLoginScreenView(
                        viewModel: viewModel,
                        topTextFont: .title2, 
                        underTopTextFormFont: .footnote, authService: authService, showLogo: true // Передаём нужный шрифт
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
        }
    }
}


