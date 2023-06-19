//
//  PostProductModel.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

// MARK: - ProductAddResponse
struct ProductAddResponse: Codable {
    var flag: Bool?
    var message: String?
    var content: ProductContent?
}



