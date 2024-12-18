//
//  MyNutritionLoginScreenUITests.swift
//  MyNutritionLoginScreenUITests
//
//  Created by Daniil on 18/12/2024.
//

import XCTest

final class MyNutritionLoginScreenUITests: XCTestCase {
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
        XCTAssertTrue(emailField.description.contains("@"), "it's not valid format")
        
    }
}
