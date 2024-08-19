//
//  NetworkManager.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private(set) var cache = NSCache<NSString, UIImage>()
    private let session: URLSession
    
    
    init(session: URLSession = .shared) {
        self.session = session
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    func fetchProducts<T: Decodable>() async throws -> T {
        guard let url = URL(string: BaseURL.gymsharkProductsURL.rawValue) else { throw GSError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GSError.unableToCompleteRequest }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GSError.decodingFailed
        }
    }
    
    
    func fetchImage(urlString: String) async throws -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    
    // add convenience methods for dependency injection testing
    func fetchProducts<T: Decodable>(using session: URLSession) async throws -> T {
        let manager = NetworkManager(session: session)
        return try await manager.fetchProducts()
    }
    
    
    func fetchImage(urlString: String, using session: URLSession) async throws -> UIImage? {
        let manager = NetworkManager(session: session)
        return try await manager.fetchImage(urlString: urlString)
    }
    
    
}
