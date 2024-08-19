//
//  NetworkManagerTests.swift
//  GymSharkTests
//
//  Created by hanif hussain on 19/08/2024.
//

import XCTest
@testable import GymShark

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager.shared
    }
    
    override func tearDown() {
        sut.cache.removeAllObjects()
        sut = nil
        super.tearDown()
    }
    
    
    func testFetchProducts_Success() async throws {
        // Set up mock URLSession
        URLProtocol.registerClass(MockURLProtocol.self)
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)
        
        // Set up mock data
        let mockData = """
    {
        "hits": [
            {
                "id": 6732609257571,
                "sku": "TEST-SKU",
                "inStock": true,
                "sizeInStock": ["s", "m", "l"],
                "availableSizes": [
                    {
                        "id": 1,
                        "inStock": true,
                        "inventoryQuantity": 10,
                        "price": 3999,
                        "size": "m",
                        "sku": "TEST-SKU-M"
                    }
                ],
                "handle": "test-product",
                "title": "Speed Leggings",
                "description": "A test product description",
                "type": "Womens Leggings",
                "gender": ["f"],
                "fit": "Regular",
                "labels": ["New", "Bestseller"],
                "colour": "Navy",
                "price": 1000,
                "compareAtPrice": "4999",
                "discountPercentage": 20.0,
                "featuredMedia": {
                    "src": "https://example.com/image.jpg",
                    "width": 800,
                    "height": 600
                },
                "media": [
                    {
                        "src": "https://example.com/image.jpg",
                        "width": 800,
                        "height": 600
                    }
                ],
                "objectID": "test-object-id"
            }
        ]
    }
    """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        do {
            // Use the convenience method with the mock session
            let products: GymsharkProducts = try await NetworkManager.shared.fetchProducts(using: mockSession)
            
            // Assert results
            XCTAssertEqual(products.hits.count, 1)
            XCTAssertEqual(products.hits.first?.id, 6732609257571)
            XCTAssertEqual(products.hits.first?.price, 1000)
            XCTAssertEqual(products.hits.first?.colour, "Navy")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
    func testFetchImage_CacheHit() async throws {
        let testImageURL = "https://cdn.shopify.com/s/files/1/1326/4923/products/SpeedLEGGINGNavy-B3A3E-UBCY.A-Edit_BK.jpg?v=1649254794"
        let testImage = try await sut.fetchImage(urlString: testImageURL)!
        
        // Populate cache
        sut.cache.setObject(testImage, forKey: NSString(string: testImageURL))
        
        // Fetch image (should hit cache)
        let result = try await sut.fetchImage(urlString: testImageURL)
        
        // Print debug information
        print("Test Image Size: \(testImage.size)")
        print("Result Image Size: \(result?.size ?? CGSize.zero)")
        
        // Assertions
        XCTAssertNotNil(result, "Fetched image should not be nil")
        XCTAssertTrue(imagesAreEqual(result, testImage), "Fetched image should match the cached image")
        
        // Check if the image is still in cache
        let cachedImage = sut.cache.object(forKey: NSString(string: testImageURL))
        print("Cached Image Size: \(cachedImage?.size ?? CGSize.zero)")
        
        XCTAssertNotNil(cachedImage, "Image should still be in cache")
        XCTAssertTrue(imagesAreEqual(cachedImage, testImage), "Cached image should match the original")
    }
    
    
    func testFetchImage_CacheMiss() async throws {
        let testImageURL = "https://cdn.shopify.com/s/files/1/1326/4923/products/SpeedLEGGINGNavy-B3A3E-UBCY.A-Edit_BK.jpg?v=1649254794"
        let testImage = try await sut.fetchImage(urlString: testImageURL)
        
        URLProtocol.registerClass(MockURLProtocol.self)
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        MockURLProtocol.requestHandler = { request in
            guard let imageData = testImage?.pngData() else {
                throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image data"])
            }
            return (HTTPURLResponse(), imageData)
        }
        
        let result = try await sut.fetchImage(urlString: testImageURL, using: urlSession)
        
        XCTAssertNotNil(result, "Fetched image should not be nil")
        XCTAssertTrue(imagesAreEqual(result, testImage), "Fetched image should match the original")
        
        // Check if the image is cached
        let cachedImage = sut.cache.object(forKey: NSString(string: testImageURL))
        XCTAssertNotNil(cachedImage, "Image should be cached after fetching")
        XCTAssertTrue(imagesAreEqual(cachedImage, testImage), "Cached image should match the original")
    }
    
    // check images are equal
    func imagesAreEqual(_ image1: UIImage?, _ image2: UIImage?) -> Bool {
        guard let image1 = image1, let image2 = image2 else {
            print("One or both images are nil")
            return false
        }
        
        guard let data1 = image1.pngData(), let data2 = image2.pngData() else {
            print("Failed to get PNG data for one or both images")
            return false
        }
        
        let result = data1 == data2
        print("Images are equal: \(result)")
        print("Image 1 data size: \(data1.count)")
        print("Image 2 data size: \(data2.count)")
        
        return result
    }
}

// Mock URLProtocol for testing network requests
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Handler is unavailable.")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
