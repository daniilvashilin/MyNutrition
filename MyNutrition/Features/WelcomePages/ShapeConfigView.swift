//
//  ShapeConfigView.swift
//  MyNutrition
//
//  Created by Daniil on 05/01/2025.
//

import SwiftUI

struct ShapeConfigView: View {
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroundColor: Color
        var keyFrameDuration: Double // Add this property
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    var config: Config
    var symbol: String
    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            if let renderImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            imageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            trigger.toggle()
            nextSymbol = newValue
            
        }
        .task {
            guard displayingSymbol == "" else {return}
            displayingSymbol = symbol
        }
    }
    
    @ViewBuilder
    func imageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = symbol
                        }
                    }
                }
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: 1.0) // Adjust duration
            CubicKeyframe(0, duration: 1.0)           // Adjust duration
        }
    }
}



#Preview {
    ShapeConfigView(config: .init(font: .largeTitle, frame: CGSize(width: 250, height: 250), radius: 15, foregroundColor: .black, keyFrameDuration: 15), symbol: "hand.raised.fill")
}
