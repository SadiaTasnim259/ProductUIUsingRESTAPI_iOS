//
//  EventHandle.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

// MARK: - Event

enum Event{
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
    
    
}
