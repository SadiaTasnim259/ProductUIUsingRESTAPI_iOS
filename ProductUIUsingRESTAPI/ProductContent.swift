//
//  ProductContent.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

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
