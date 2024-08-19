//
//  ProductDescriptionVCTests.swift
//  GymSharkTests
//
//  Created by hanif hussain on 19/08/2024.
//

import XCTest
@testable import GymShark

class ProductDescriptionVCTests: XCTestCase {
    
    var sut: ProductDescriptionVC!
    
    override func setUp() {
        super.setUp()
        sut = ProductDescriptionVC(productDescription: "<p>Test Description</p>")
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testInitialization() {
        XCTAssertEqual(sut.productDescription, "Test Description")
    }
    
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        XCTAssertNotNil(sut.label)
        XCTAssertEqual(sut.label.text, "Test Description")
    }
}
