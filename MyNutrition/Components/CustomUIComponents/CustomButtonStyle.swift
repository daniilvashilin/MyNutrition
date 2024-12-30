import Foundation
import SwiftUI


struct CustomButtonStyle: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let textColor: Color
    let backGroundColor: Color
    let cornerRadius: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(width: width, height: height)
            .foregroundStyle(textColor)
            .background(backGroundColor)
            .cornerRadius(cornerRadius)
    }
}
