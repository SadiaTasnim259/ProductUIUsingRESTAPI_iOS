//
//  ProductModel.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

// MARK: - GetProductModel
struct GetProductModelList: Codable {
    var flag: Bool?
    var message: String?
    var content: [ProductContent]?
}

// MARK: - Content
struct ProductContent: Codable {
    var id, name: String?
    var quentity, price: Int?
    var image: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, quentity, price, image, createdAt, updatedAt
    }
}
