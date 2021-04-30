//
//  Models.swift
//  NetworkingLayerDemoApp
//
//  Created by Kevin Vu on 3/31/21.
//

import Foundation

// MARK: - Collection item
struct CollectionItem: Codable {
    let title: String
    let id: Int
}

// MARK: - Collection item id
struct CollectionItemId: Codable {
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
}

// MARK: - Collection Info
struct CollectionInfo: Codable {
    let title: String
    let productType: String
    let variants: [VariantsInfo]
    let image: ImageInfo
    
    enum CodingKeys: String, CodingKey {
        case title,
             productType = "product_type",
             variants,
             image
    }
}

// MARK: - Variants Info
struct VariantsInfo: Codable {
    let title: String
    let inventoryQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case title,
             inventoryQuantity = "inventory_quantity"
    }
}

// MARK: - Image info
struct ImageInfo: Codable {
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "src"
    }
}
