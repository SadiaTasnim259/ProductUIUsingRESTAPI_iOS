//
//  ProductUpdateResponse.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 21/6/23.
//

import Foundation

struct ProductUpdateResponse: Codable {
    var flag: Bool?
    var message: String?
    var content: ProductContent?
}
