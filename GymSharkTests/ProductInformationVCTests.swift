//
//  ProductInformationVCTests.swift
//  GymSharkTests
//
//  Created by hanif hussain on 19/08/2024.
//

import XCTest
@testable import GymShark

class ProductInformationVCTests: XCTestCase {
    
    var sut: ProductInformationVC!
    var window: UIWindow!
    var mockProduct: Hit!
    
    override func setUp() {
        super.setUp()
        
        // Set up mock data
        mockProduct =
        Hit(
            id: 6732609257571,
            sku: "TEST-SKU1",
            inStock: true,
            sizeInStock: [Size.xs, Size.l, Size.xl],
            availableSizes: [
                AvailableSize(id: 39814344835171, inStock: true, inventoryQuantity: 1, price: 1000, size: .xs, sku: "TEST-SKU1-XS"),
                AvailableSize(id: 39814344933475, inStock: true, inventoryQuantity: 1, price: 1000, size: .l, sku: "TEST-SKU1-L"),
                AvailableSize(id: 39814344966243, inStock: true, inventoryQuantity: 1, price: 1000, size: .xl, sku: "TEST-SKU1-XL")
            ],
            handle: "test-product-1",
            title: "Test Product 1",
            description: "This is a test product description for Product 1",
            type: "Test Type",
            gender: ["f"],
            fit: "Regular",
            labels: ["New", "Featured"],
            colour: "Blue",
            price: 1000,
            compareAtPrice: "1200",
            discountPercentage: 16.67,
            featuredMedia: Media(
                adminGraphqlAPIID: "gid://shopify/ProductImage/29035954831459",
                alt: nil,
                createdAt: Date(),
                height: 2018,
                id: 29035954831459,
                position: 1,
                productID: 6732609257571,
                src: "https://example.com/test-image-1.jpg",
                updatedAt: Date(),
                variantIDS: [],
                width: 1692
            ),
            media: [
                Media(
                    adminGraphqlAPIID: "gid://shopify/ProductImage/29035954831459",
                    alt: nil,
                    createdAt: Date(),
                    height: 2018,
                    id: 29035954831459,
                    position: 1,
                    productID: 6732609257571,
                    src: "https://example.com/test-image-1.jpg",
                    updatedAt: Date(),
                    variantIDS: [],
                    width: 1692
                )
            ],
            objectID: "6732609257571"
        )
        
        sut = ProductInformationVC(product: mockProduct)
    }
    
    
    override func tearDown() {
        sut = nil
        window = nil
        mockProduct = nil
        super.tearDown()
    }
    
    
    func setupWindowAndRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: sut)
        window.rootViewController = navigationController
    }
    
    
    func testInitialization() {
        XCTAssertNotNil(sut.product)
        XCTAssertEqual(sut.product.id, 6732609257571)
    }
    
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.productInfoView)
        XCTAssertTrue(sut.productInfoView.productDetailView.delegate === sut)
    }
    
    func testShowProductDescription() {
        sut.loadViewIfNeeded()
        
        sut = ProductInformationVC(product: mockProduct)
        setupWindowAndRootViewController()
        
        // Act
        sut.showProductDescription(description: "Test Description")
        
        // Assert
        let expectation = XCTestExpectation(description: "Wait for presentation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.sut.presentedViewController, "A view controller should be presented")
            XCTAssertTrue(self.sut.presentedViewController is ProductDescriptionVC, "The presented view controller should be ProductDescriptionVC")
            
            if let productDescriptionVC = self.sut.presentedViewController as? ProductDescriptionVC {
                XCTAssertEqual(productDescriptionVC.productDescription, "Test Description", "The product description should match")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
