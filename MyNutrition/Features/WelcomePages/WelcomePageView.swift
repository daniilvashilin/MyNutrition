//
//  WelcomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI

struct WelcomePageView: View {
    @State var pages: Page = .greetings
    var body: some View {
        GeometryReader { geom in
            TabView(selection: $pages) {
                ForEach(Page.allCases, id: \.self) { page in
                    VStack(alignment: .center) {
                        HStack {
                            Button {
                                pages = page.previousPage
                            } label: {
                                Image(systemName: pages == .greetings ? "help.circle" : "arrowshape.backward.fill")
                                    .font(.custom("backButton", fixedSize: geom.size.width * 0.05))
                                    .foregroundStyle(.text)
                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                        Image(systemName: page.image)
                            .font(.custom("title", fixedSize: geom.size.width * 0.3))
                            .padding()
                        
                        VStack(alignment: .center) {
                            Text(page.title)
                                .font(.custom("title", fixedSize: geom.size.width * 0.07))
                                .padding()
                            Text(page.description)
                                .font(.custom("title", fixedSize: geom.size.width * 0.045))
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: geom.size.width * 0.8, height: geom.size.height * 0.2, alignment: .center)
                        Spacer()
                        Button {
                                pages = page.nextPage
                        } label: {
                            Text(page == .analytics ? "Get started" : "Continue")
                                .frame(width: geom.size.width * 0.4, height: geom.size.height * 0.08, alignment: .center)
                                .background(.textField)
                                .clipShape(RoundedRectangle(cornerRadius: geom.size.width * 0.1))
                        }
                        .animation(.easeInOut(duration: 0.5), value: pages)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}


struct WelcomePagesPreview: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
