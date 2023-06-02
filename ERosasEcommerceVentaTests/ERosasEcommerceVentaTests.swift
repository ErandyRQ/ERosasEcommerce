//
//  ERosasEcommerceVentaTests.swift
//  ERosasEcommerceVentaTests
//
//  Created by MacBookMBA9 on 29/05/23.
//

import XCTest

@testable import ERosasEcommerceVenta

final class ERosasEcommerceVentaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let carritoViewModel = CarritoViewModel()
        let result = carritoViewModel.GetAll()
        
        XCTAssertTrue(result.Correct!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
