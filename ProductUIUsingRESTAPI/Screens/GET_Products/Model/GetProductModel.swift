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

