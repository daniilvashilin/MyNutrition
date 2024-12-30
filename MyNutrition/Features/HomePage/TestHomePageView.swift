import SwiftUI
import FirebaseAuth

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authservice: AuthService
    @EnvironmentObject var nutritionService: NutritionService
    var body: some View {
        VStack {
            CaloriesGroupBoxView()
//            if let data = nutritionService.nutritionData {
//                Text("Calories Goal: \(data.caloriesGoal)")
//                Text("Calories Consumed: \(data.current.caloriesConsumed)")
//            } else {
//                Text("Loading data...")
//            }
//            
//            Button {
//                Task {
//                    do {
//                      try  authservice.signOut()
//                    }
//                }
//            } label: {
//                Text("Signout")
//            }

        }
        .padding()
    }
}

