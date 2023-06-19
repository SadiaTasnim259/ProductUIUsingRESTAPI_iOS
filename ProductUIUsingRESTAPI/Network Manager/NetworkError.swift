//
//  NetworkError.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation


enum NetworkErrors:String, LocalizedError {
    case invalidURL         = "There was an issue connecting to the server. If this persists, please contact support."
    case invalidRequest     = "There was an issue on the request. If this keeps happening, please contact support."
    case invalidResponse    = "Invalid response from the server. Please try again letter or contact support."
    case invalidData        = "The data received from the server was invalid. Please contact support."
    case unableToComplete   = "Unable to complete your request at this time. Please check your internet connection."
    
    var errorDescription: String?{self.rawValue}
}

