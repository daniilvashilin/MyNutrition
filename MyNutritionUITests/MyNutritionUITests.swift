//
//  MyNutritionUITests.swift
//  MyNutritionUITests
//
//  Created by Daniil on 19/12/2024.
//

import XCTest


final class MyNutritionUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testEmailFieldExists() throws {
        let emailField = app.textFields["Enter email"]
        XCTAssertTrue(emailField.exists, "The email input field does not exist on the screen.")
    }
    
    func testPsswordFieldExists() throws {
        let passwordField = app.secureTextFields["Enter password"]
        XCTAssertTrue(passwordField.exists, "The password input field does not exist on the screen.")
    }
    
    func testSignInButtonIsHittable() throws {
        let signInButton = app.buttons["Sign in"]
        XCTAssertTrue(signInButton.exists, "Can't find the Sign in button")
        XCTAssertTrue(signInButton.isHittable, "Sign in button is not hittable")
    }
    
    func testRegisterButtonIsHittable() throws {
        let registerButton = app.buttons["Register"]
        XCTAssertTrue(registerButton.exists, "Can't find the Register button")
        XCTAssertTrue(registerButton.isHittable, "Register button is not hittable")
    }
    
    func testAppleSignInButtonIsHittable() throws {
        let appleSignInButton = app.buttons["Sign in with Apple"]
        XCTAssertTrue(appleSignInButton.exists, "Can't find the Apple Sign in button")
        XCTAssertTrue(appleSignInButton.isHittable, "Apple Sign in button is not hittable")
    }
    
    func testEmailEnterContentIsValid() throws {
        let emailField = app.textFields["Enter email"]
        XCTAssertTrue(emailField.exists, "Email input field does not exist.")
        XCTAssertTrue(emailField.isHittable, "Email input field is not hittable.")
        
        emailField.tap()
        let testEmail = "testEmail@example.com"
        emailField.typeText(testEmail)
        
        let emailValue = emailField.value as? String ?? ""
        XCTAssertTrue(emailValue.contains("@"), "Wrong email format")
        XCTAssertTrue(emailValue.count <= 33, "Email is too long")
        XCTAssertTrue(emailValue.first?.isLetter ?? false, "Email must start with a letter")
        XCTAssertFalse(emailValue.first?.isNumber ?? false, "Email can't start with number")
        XCTAssertFalse((emailValue.hasPrefix(".")), "Email can't start with a dot")
        XCTAssertFalse(emailValue.hasSuffix("."), "Email can't end with a dot")
        XCTAssertTrue(emailValue.contains("."), "Email must have less one dot")
    }
    
    func testPasswordEnterContentIsValid() throws {
        let passwordField = app.secureTextFields["Enter password"]
        XCTAssertTrue(passwordField.exists, "Password input fireld does not exist")
        XCTAssertTrue(passwordField.isHittable, "Password input field is not hittable")
        
        passwordField.tap()
        let testPassword = "randomPassword!12"
        passwordField.typeText(testPassword)
        
//        let passwordValue = passwordField.value as? String ?? ""
    }
    
    func testSignInWithValidCredentials() throws {
        let emailField = app.textFields["Enter email"]
        let passwordField = app.secureTextFields["Enter password"]
        let signInButton = app.buttons["Sign in"]
        
        emailField.tap()
        emailField.typeText("testEmail@example.com")
        
        passwordField.tap()
        passwordField.typeText("ValidPassword123")
        
        signInButton.tap()
        
        //        let loadingIndicator = app.activityIndicators["In progress"]
        //        XCTAssertTrue(loadingIndicator.exists, "Loading indicator did not appear after sign in.")
    }
    
    func testRegisterWithValidCredentials() throws {
        let emailField = app.textFields["Enter email"]
        let passwordField = app.secureTextFields["Enter password"]
        let registerButton = app.buttons["Register"]
        
        emailField.tap()
        emailField.typeText("testEmail@example.com")
        
        passwordField.tap()
        passwordField.typeText("ValidPassword123")
        
        registerButton.tap()
        
        //        let loadingIndicator = app.activityIndicators["In progress"]
        //        XCTAssertTrue(loadingIndicator.exists, "Loading indicator did not appear after sign in.")
    }
    
}
