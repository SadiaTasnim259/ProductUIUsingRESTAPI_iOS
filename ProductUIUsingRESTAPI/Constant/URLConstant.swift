//
//  URLConstant.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

enum API{
    static let BASE_URL = "http://192.168.0.100:3000/"
    
    static let GET_ALL_PRODUCTS = BASE_URL+"products"
    static let POST_PRODUCT = BASE_URL+"product"
    static let DELETE_PRODUCT = BASE_URL+"products/"
    
}
