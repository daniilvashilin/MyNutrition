//
//  WelcomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI

struct WelcomePageView: View {
    @State var activePage: Page = .greetings
    @State var goToHomePage = false
    var body: some View {
        NavigationStack {
            GeometryReader { geom in
                // page
                VStack {
                    Spacer()
                    ShapeConfigView(config: .init(font: .system(size: 150, weight: .bold), frame: .init(width: 300, height: 300), radius: 15, foregroundColor: .text, keyFrameDuration: 15), symbol: activePage.image)
                    TextContainer(size: geom.size, activePage: activePage)
                    Spacer()
                    ContinueButton()
                    
                }
                .frame(width: geom.size.width, height: geom.size.height)
            }
        }
        .navigationDestination(isPresented: $goToHomePage) {
            FinalIphoneMainView()
        }
    }
    // text
    @ViewBuilder
    func TextContainer(size: CGSize, activePage: Page) -> some View {
        VStack(spacing: 8) {
            // HStack for all titles
            HStack(spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .font(.title)
                        .lineLimit(1)
                        .fontWeight(.bold)
                        .foregroundStyle(.text)
                        .kerning(1.1)
                        .frame(width: size.width) // Each page occupies full width
                }
            }
            .frame(width: size.width, alignment: .leading) // Total HStack width
            .offset(x: -activePage.index * size.width) // Shift HStack based on active page
            .animation(.smooth(duration: 0.5), value: activePage) // Animate sliding
            .multilineTextAlignment(.center)
            
            HStack(spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.description)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .frame(width: size.width) // Each page occupies full width
                }
            }
            .frame(width: size.width, alignment: .leading) // Total HStack width
            .offset(x: -activePage.index * size.width) // Shift HStack based on active page
            .animation(.smooth(duration: 0.7), value: activePage) // Animate sliding
            .multilineTextAlignment(.center)
        }
    }
    
    // Button
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            if activePage == .analytics {
                goToHomePage = true
            } else {
                activePage = activePage.nextPage
            }
        } label: {
            Text(activePage == .analytics ? "Get started" : "Continue")
                .padding()
                .contentTransition(.identity)
                .frame(maxWidth: activePage == .analytics ? 220 : 160)
                .background(.customGreen, in: .capsule)
                .foregroundStyle(.text)
        }
        .padding()
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
}




