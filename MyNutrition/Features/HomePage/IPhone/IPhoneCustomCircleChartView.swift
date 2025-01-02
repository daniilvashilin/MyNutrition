import SwiftUI


struct IPhoneCustomCircleChartView: View {
    var goal: Double
    var strokeColor: Color
    var gradientColor: Color
    var current: Double
    var lineWidth: CGFloat
    var circleWidth: CGFloat
    var circleHeight: CGFloat
    var result: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.2)
                .foregroundColor(.secondary)
            
            if current > 0 {
                Circle()
                    .trim(from: 0.0, to: CGFloat(current / goal))
                    .stroke(Gradient(colors: [strokeColor, gradientColor]),
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 1), value: current)
            }
                VStack {
                    Text("\(result, format: .number.grouping(.automatic).precision(.fractionLength(0)))")
                        .font(.custom("AdaptiveSize", fixedSize: circleWidth * 0.13))
                        .foregroundStyle(.text)
                    Text("/\(goal, format: .number.grouping(.automatic).precision(.fractionLength(0)))")
                        .font(.custom("AdaptiveSize", fixedSize: circleWidth * 0.08))
                        .foregroundStyle(.text.opacity(0.5))
                
            }
        }
        .frame(width: circleWidth, height: circleHeight)
    }
}

//#Preview {
//    var currentP = 35
//    var goalP = 300
//    IPhoneCustomCircleChartView(goal: Double(goalP), strokeColor: .purple, gradientColor: .pink, current: Double(currentP), lineWidth: 15, circleWidth: 300, circleHeight: 300, result: Double(goalP - currentP))
//}
