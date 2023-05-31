//
//  ERosasEcommerceVentaUITests1.swift
//  ERosasEcommerceVentaUITests1
//
//  Created by MacBookMBA9 on 30/05/23.
//

import XCTest

final class ERosasEcommerceVentaUITests1: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //Boton de registrar nuevo usuario
        let button = app.buttons["Registro"]
        XCTAssertTrue (button.exists)
        button.tap()
        
        //Boton de acceder
        let button2 = app.buttons["BtnAcceso"]
        button2.exists
       // XCTAssertTrue (button2.exists)
       // button.tap()
        
        //Text field de email
       let email = app.textFields["TxtEmail"]
        email.exists
        //XCTAssertTrue(email.exists)
       // email.typeText("erandy@gmail.com")
        
        //Text field de password
        let password = app.textFields["TxtPassword"]
         password.exists
        // XCTAssertTrue(password.exists)
        // password.typeText("123456")

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
