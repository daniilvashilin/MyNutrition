//
//  WelcomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI

struct WelcomePageView: View {
    @State private var skip = false
    @EnvironmentObject var viewModel: BaseAuthViewModel
    @EnvironmentObject var authservice: AuthService
    var body: some View {
        GeometryReader {geom in
            NavigationStack {
                ZStack {
                    Color.backGround
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        SelectThemeView()
                        Spacer()
                        ButtonsNextSkitView(widthButton: geom.size.width * 0.2,
                                            heightButton: geom.size.height * 0.06,
                                            fontSize: geom.size.width * 0.04, skipAccess: $skip, skipDestination: AnyView(TestViewSkip()), nextDestination: AnyView(IPhoneScreenView()), disabled: $skip)
                    }
                    .padding()
                }
            }
        }
    }
}

//
//#Preview {
//    WelcomePageView()
//}
