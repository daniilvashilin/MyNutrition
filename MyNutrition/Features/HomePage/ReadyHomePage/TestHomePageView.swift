import SwiftUI
import FirebaseAuth

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authservice: AuthService
    @EnvironmentObject var nutritionService: NutritionService
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var isAddPressed = false
    @State var selection = 0
    var body: some View {
        ZStack {
            Color.backGround
                .edgesIgnoringSafeArea(.all)
                .ignoresSafeArea(.all)
           
                VStack(spacing: 15) {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        HeaderView(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.05)
                        ScrollView {
                            TabView(selection: $selection) {
                                IPhoneDashBoardGroupBoxView(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.35)
                                    .tag(0)
                                LowCarbsIPhoneView(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.35)
                                    .tag(1)
                                WeightChartView(width: UIScreen.main.bounds.width * 0.9 , height: UIScreen.main.bounds.height * 0.35, addButtonPressed: $isAddPressed)
                                    .tag(2)
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.35)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .animation(nil, value: selection)
                            
                            HStack {
                                ForEach(0..<3, id: \.self) { index in
                                    Circle()
                                        .fill(selection == index ? .circleGreen : .secondary)
                                        .frame(width: UIScreen.main.bounds.width * 0.02)
                                }
                            }
                            IPhoneMacrosBoardView(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
                            ////                        Button {
                            ////                            Task {
                            ////                               try authservice.signOut()
                            ////                            }
                            ////                        } label: {
                            ////                            Text("Signout")
                            ////                        }
                            ///
                        }
                        .sheet(isPresented: $isAddPressed) {
                            AddWeightView(closeTab: $isAddPressed)
                        }
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        if verticalSizeClass == .regular {
                            Text("iPad Portrait")
                        } else {
                            Text("iPad Landscape")
                        }
                    }
                }
                .padding()
             // here
        }
    }
}
