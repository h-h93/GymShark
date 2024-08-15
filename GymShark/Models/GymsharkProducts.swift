//
//  GymsharkProducts.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import Foundation

// MARK: - GymsharkProducts
struct GymsharkProducts: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let id: Int
    let sku: String
    let inStock: Bool
    let sizeInStock: [Size]?
    let availableSizes: [AvailableSize]?
    let handle, title, description: String?
    let type: String?
    let gender: [String]?
    let fit: String?
    let labels: [String]?
    let colour: String
    let price: Int
    let compareAtPrice: String?
    let discountPercentage: Double?
    let featuredMedia: Media
    let media: [Media]
    let objectID: String
}

// MARK: - AvailableSize
struct AvailableSize: Codable {
    let id: Int
    let inStock: Bool
    let inventoryQuantity, price: Int
    let size: Size
    let sku: String
}

enum Size: String, Codable {
    case l = "l"
    case m = "m"
    case s = "s"
    case xl = "xl"
    case xs = "xs"
    case xxl = "xxl"
}

// MARK: - Media
struct Media: Codable {
    let adminGraphqlAPIID: String?
    let alt: String?
    let createdAt: Date?
    let height, id, position, productID: Int?
    let src: String
    let updatedAt: Date?
    let variantIDS: [Int]?
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case alt
        case createdAt = "created_at"
        case height, id, position
        case productID = "product_id"
        case src
        case updatedAt = "updated_at"
        case variantIDS = "variant_ids"
        case width
    }
}

enum Gender: String, Codable {
    case f = "f"
}

enum TypeEnum: String, Codable {
    case womensLeggings = "Womens Leggings"
}
