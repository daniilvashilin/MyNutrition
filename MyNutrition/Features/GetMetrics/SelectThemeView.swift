//
//  SelectThemeView.swift
//  MyNutrition
//
//  Created by Daniil on 04/01/2025.
//

import SwiftUI

struct SelectThemeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        let gradientDarkColor: Gradient = Gradient(colors: [.yellow, .orange])
        let gradientLightColor: Gradient = Gradient(colors: [.white, .blue])
        GeometryReader {geom in
            VStack {
                Image(themeManager.isDarkMode ? .nightMode : .sunMode)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: geom.size.width * 0.3, height: geom.size.height * 0.16)
                    .foregroundStyle(themeManager.isDarkMode ? gradientLightColor : gradientDarkColor)
                    .padding()
                
                VStack {
                    Text("Choose a color scheme")
                        .foregroundStyle(themeManager.isDarkMode ? .white : .black)
                }
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.2)
                
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            themeManager.isDarkMode = false
                        }
                    } label: {
                        Text("Light")
                            .foregroundStyle(themeManager.isDarkMode == false  ? .black : .black)
                    }
                    .frame(width: geom.size.width * 0.25, height: geom.size.height * 0.06)
                    .background(themeManager.isDarkMode == false ? .white : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: geom.size.width * 0.1))
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            themeManager.isDarkMode = true
                        }
                    } label: {
                        Text("Dark")
                            .foregroundStyle(themeManager.isDarkMode == true ? .white : .black)
                    }
                    .frame(width: geom.size.width * 0.25, height: geom.size.height * 0.06)
                    .background(themeManager.isDarkMode == true ? .black : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: geom.size.width * 0.1))
                }
                .frame(width: geom.size.width * 0.6, height: geom.size.height * 0.1)
                .background(.textField)
                .clipShape(RoundedRectangle(cornerRadius: geom.size.width * 0.1))
                .padding()
            }
            .frame(width: geom.size.width, height: geom.size.height)
        }
    }
}




import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = true
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}
