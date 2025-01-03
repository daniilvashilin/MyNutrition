import SwiftUI
import FirebaseAuth

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authservice: AuthService
    @EnvironmentObject var nutritionService: NutritionService
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack {
            Color.backGround
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    // Убираем GeometryReader из ScrollView, если он не нужен
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        IPhoneDashBoardGroupBoxView(
                            width: UIScreen.main.bounds.width * 0.9, // Используем экранную ширину
                            height: UIScreen.main.bounds.height * 0.3 // Пропорциональная высота
                        )
                        .frame(maxWidth: .infinity) // Задаем максимальную ширину
                        IPhoneMacrosBoardView(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        if verticalSizeClass == .regular {
                            Text("iPad Portrait")
                        } else {
                            Text("iPad Landscape")
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
//            healthKitManager.requestHealthDataAccess()
        }
    }
}
