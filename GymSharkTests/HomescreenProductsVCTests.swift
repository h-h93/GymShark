//
//  HomescreenProductsVCTests.swift
//  GymSharkTests
//
//  Created by hanif hussain on 19/08/2024.
//

import XCTest
@testable import GymShark

class HomescreenProductsVCTests: XCTestCase {
    
    var sut: HomescreenProductsVC!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = HomescreenProductsVC(networkManager: mockNetworkManager)
    }
    
    
    override func tearDown() {
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    
    func testConfigureCollectionView() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.collectionView, "CollectionView should be initialized")
        XCTAssertTrue(sut.collectionView.delegate === sut, "CollectionView delegate should be set")
        XCTAssertNotNil(sut.collectionView.dataSource, "CollectionView dataSource should be set")
        XCTAssertTrue(sut.collectionView.dataSource is UICollectionViewDiffableDataSource<HomescreenProductsVC.Section, Hit>, "DataSource should be of correct type")
    }
    
    
    func testUpdateProductList() {
        sut.loadViewIfNeeded()
        
        let testProducts = [
            Hit(
                id: 6732609257571,
                sku: "TEST-SKU1",
                inStock: true,
                sizeInStock: nil,
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
            ),
            
            Hit(
                id: 6732607094883,
                sku: "TEST-SKU2",
                inStock: true,
                sizeInStock: nil,
                availableSizes: [
                    AvailableSize(id: 39814339723363, inStock: true, inventoryQuantity: 2, price: 1500, size: .s, sku: "TEST-SKU2-S"),
                    AvailableSize(id: 39814339756131, inStock: true, inventoryQuantity: 3, price: 1500, size: .m, sku: "TEST-SKU2-M"),
                    AvailableSize(id: 39814339788899, inStock: true, inventoryQuantity: 1, price: 1500, size: .l, sku: "TEST-SKU2-L")
                ],
                handle: "test-product-2",
                title: "Test Product 2",
                description: "This is a test product description for Product 2",
                type: "Test Type",
                gender: ["m"],
                fit: "Slim",
                labels: ["Bestseller"],
                colour: "Red",
                price: 1500,
                compareAtPrice: "1800",
                discountPercentage: 16.67,
                featuredMedia: Media(
                    adminGraphqlAPIID: "gid://shopify/ProductImage/29031260979299",
                    alt: nil,
                    createdAt: Date(),
                    height: 2018,
                    id: 29031260979299,
                    position: 1,
                    productID: 6732607094883,
                    src: "https://example.com/test-image-2.jpg",
                    updatedAt: Date(),
                    variantIDS: [],
                    width: 1692
                ),
                media: [
                    Media(
                        adminGraphqlAPIID: "gid://shopify/ProductImage/29031260979299",
                        alt: nil,
                        createdAt: Date(),
                        height: 2018,
                        id: 29031260979299,
                        position: 1,
                        productID: 6732607094883,
                        src: "https://example.com/test-image-2.jpg",
                        updatedAt: Date(),
                        variantIDS: [],
                        width: 1692
                    )
                ],
                objectID: "6732607094883"
            )
        ]
        
        sut.products = testProducts
        sut.updateProductList()
        
        // Wait for the main queue to process the update
        let expectation = XCTestExpectation(description: "Update product list")
        DispatchQueue.main.async {
            let snapshot = self.sut.dataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, testProducts.count, "DataSource should have the correct number of items")
            XCTAssertEqual(snapshot.numberOfSections, 1, "DataSource should have one section")
            XCTAssertEqual(snapshot.sectionIdentifiers, [.main], "DataSource should have the main section")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testConfigureData() {
        let expectation = XCTestExpectation(description: "Configure data")
        
        // Set up mock data
        let mockProducts = GymsharkProducts(hits: [
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
        ])
        mockNetworkManager.mockProducts = mockProducts
        
        sut.loadViewIfNeeded()
        sut.configureData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.sut.products.count, 1, "Should have fetched one product")
            XCTAssertEqual(self.sut.products.first?.id, 6732609257571, "Should have fetched the correct product")
            
            let snapshot = self.sut.dataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 1, "DataSource should have one item")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock NetworkManager for testing
class MockNetworkManager: NetworkManager {
    var mockProducts: GymsharkProducts?
    
    override func fetchProducts<T>() async throws -> T where T : Decodable {
        guard let products = mockProducts as? T else {
            throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock products not set or of wrong type"])
        }
        return products
    }
}
