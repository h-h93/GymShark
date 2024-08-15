//
//  NetworkManager.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getProducts() async throws -> GymsharkProducts {
        guard let url = URL(string: BaseURL.gymsharkProductsURL.rawValue + "9") else { throw GSError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GSError.unableToCompleteRequest }
        
        do {
            //print(String(decoding: data, as: UTF8.self))
            return try decoder.decode(GymsharkProducts.self, from: data)
        } catch {
            throw GSError.decodingFailed
        }
    }
}
