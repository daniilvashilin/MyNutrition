//
//  IPadScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI

struct IPadScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel = BaseAuthViewModel()
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
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4, alignment: .center)
                            .edgesIgnoringSafeArea(.top)
                        ReadyScreenView(viewModel: viewModel)
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
                        
                        ReadyScreenView(viewModel: viewModel)
                                .frame(width: geometry.size.width * 0.5)
                    }
                    .ignoresSafeArea(.keyboard)
                }
            }
        }
    }
}

#Preview {
    IPadScreenView()
}
