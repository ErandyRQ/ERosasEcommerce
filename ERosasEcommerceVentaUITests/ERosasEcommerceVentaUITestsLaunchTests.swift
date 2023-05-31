//
//  ERosasEcommerceVentaUITestsLaunchTests.swift
//  ERosasEcommerceVentaUITests
//
//  Created by MacBookMBA9 on 30/05/23.
//

import XCTest

final class ERosasEcommerceVentaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let button = app.buttons["Btn Acceso"]
        button.exists
        XCTAssertTrue (button.exists)
        button.tap()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
