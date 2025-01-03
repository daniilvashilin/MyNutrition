//
//  IPadRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct IPadRegisterScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var authService: AuthService
    @ObservedObject var viewModel: BaseAuthViewModel
    @EnvironmentObject var appState: AppState
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.backGround)
                    .edgesIgnoringSafeArea(.all)
                if geometry.size.width < geometry.size.height {
                    VStack(spacing: 15) {
                        Image(.compactScreen)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center)
                            .edgesIgnoringSafeArea(.top)
                            .accessibilityIdentifier("compactScreen")
                        ReadyRegisterScreenView(
                            viewModel: viewModel, authService: authService,
                            topTextFont: .largeTitle,
                            underTopTextFormFont: .title2, showLogo: false
                        )
                        .frame(width: geometry.size.width)
                        Spacer()
                    }
                    .ignoresSafeArea(.keyboard)
                } else if geometry.size.width > geometry.size.height  {
                    HStack(spacing: 0) {
                        Image(.screenRegular)
                            .resizable()
                               .scaledToFill()
                               .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                               .ignoresSafeArea()
                            .accessibilityIdentifier("screenRegular")
                        ReadyRegisterScreenView(
                            viewModel: viewModel, authService: authService,
                            topTextFont: .largeTitle,
                            underTopTextFormFont: .title2, showLogo: false
                        )
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                    }
                    
                }
            }
        }
    }
}

