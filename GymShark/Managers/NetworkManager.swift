//
//  NetworkManager.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchProducts <T: Decodable>() async throws -> T {
        guard let url = URL(string: BaseURL.gymsharkProductsURL.rawValue) else { throw GSError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GSError.unableToCompleteRequest }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GSError.decodingFailed
        }
    }
    
    
    func fetchImage(urlString: String) async throws  -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
    
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
