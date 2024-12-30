import SwiftUI
import AuthenticationServices

struct ReadyLoginScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    var topTextFont: Font
    var underTopTextFormFont: Font
    @ObservedObject var authService: AuthService
    @EnvironmentObject var appState: AppState
    @State private var showRegisterScreen = false
    @State private var isAuthenticated = false
    @State private var signInError: String? = nil
    var showLogo: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 15) {
                    Spacer()
                    if showLogo {
                        Image("LogoIcon")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.text)
                            .frame(width: 50, height: 50)
                    }
                    
                    Text("Welcome to MyNutrition")
                        .font(topTextFont)
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    Text("Enter your email and password or access your account")
                        .font(underTopTextFormFont)
                        .foregroundStyle(.subText)
                        .padding(.bottom, 10)
                    
                    // Поля ввода
                    CustomTextFiledVIew(
                        width: UIScreen.main.formWidth,
                        height: 45,
                        text: $viewModel.email,
                        viewModel: viewModel
                    )
                    .padding(.bottom, 10)
                    
                    CustomSecurFieldView(
                        width: UIScreen.main.formWidth,
                        height: 45,
                        text: $viewModel.password,
                        viewModel: viewModel
                    )
                    .padding(.bottom, 20)
                    
                    // Кнопки
                    Button {
                        Task {
                            do {
                                try await viewModel.signInWithEmail()
                            } catch {
                                signInError = viewModel.errorMessage
                                print("Login failed: \(String(describing: signInError))")
                            }
                        }
                    } label: {
                        Text("Sign in")
                    }
                    .getCustomButtonStyle(width: UIScreen.main.formWidth, height: 45, textColor: .white, backGroundColor: .black, cornerRadius: 10)
                    Button {
                        appState.showRegisterScreen = true
                    } label: {
                        Text("Register")
                    }
                    .getCustomButtonStyle(width: UIScreen.main.formWidth, height: 40, textColor: .text, backGroundColor: .textField, cornerRadius: 10)
                    .fullScreenCover(isPresented: $appState.showRegisterScreen) {
                        FinalRegisterScreenView(viewModel: viewModel, authService: authService)
                            .environmentObject(appState)
                    }
                    
                    // "Sign in with Apple"
                    VStack(spacing: 5) {
                        SignInWithAppleButtonView { result in
                            switch result {
                            case .success(let authorization):
                                if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                                    AuthService.shared.signInWithApple(credential: appleIDCredential) { result in
                                        switch result {
                                        case .success(let authResult):
                                            print("Пользователь авторизован: \(authResult.user.uid)")
                                            DispatchQueue.main.async {
                                                isAuthenticated = true
                                            }
                                        case .failure(_):
                                            signInError = "Apple Sign in not working"
                                        }
                                    }
                                } else {
                                    signInError = "Apple Sign in not working"
                                }
                            case .failure(_):
                                signInError = "Apple Sign in not working"
                            }
                        }
                        if let error = signInError {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Need help? Visit support page 􀬂")
                        .foregroundStyle(.subText)
                        .font(.footnote)
                }
                .padding()
            }
        }
    }
}
