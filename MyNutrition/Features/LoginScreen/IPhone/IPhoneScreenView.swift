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
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                    ReadyLoginScreenView(
                        viewModel: viewModel,
                        topTextFont: .title2, // Передаём нужный шрифт
                        underTopTextFormFont: .footnote, showLogo: true // Передаём нужный шрифт
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
        }
    }
}


