//
//  IPadRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct IPadRegisterScreenView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    //    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.backGround)
                    .edgesIgnoringSafeArea(.all)
                if geometry.size.width < geometry.size.height {
                    // Ipad LandScape
                    VStack {
                        Image(.compactScreen)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4, alignment: .center)
                            .edgesIgnoringSafeArea(.top)
                            .accessibilityIdentifier("compactScreen")
                    }
                    .ignoresSafeArea()
                    .ignoresSafeArea(.keyboard)
                    
                } else if geometry.size.width > geometry.size.height  {
                    // Ipad Portrait
                    HStack {
                        
                    }
                    .ignoresSafeArea()
                    .ignoresSafeArea(.keyboard)
                }
            }
        }
    }
}

#Preview {
    IPadRegisterScreenView()
}
