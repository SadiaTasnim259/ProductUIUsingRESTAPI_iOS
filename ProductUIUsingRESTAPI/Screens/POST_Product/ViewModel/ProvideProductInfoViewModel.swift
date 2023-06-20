//
//  ProvideProductInfoViewModel.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

final class ProvideProductInfoViewModel {
    
    var eventHandler: ((_ event: Event) -> Void)?

// MARK: - Event handler initialization
    func initEventController(_ event: @escaping (_ event: Event) -> Void) {
        self.eventHandler = event
    }

// MARK: - Post Product
    
    func addProduct(name:String, price:String, quentity:String, image:String){
        self.eventHandler?(.loading)
        var parameter:[String:Any] = [:]
        parameter["name"] = name
        parameter["price"] = price
        parameter["quentity"] = quentity
        parameter["image"] = image
        
        NetworkManager.shared.httpRequest(urlString: API.POST_PRODUCT, httpMethodType: .POST(params: parameter), respnseType: ProductAddResponse.self) { result in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                    if success.flag ?? false{
                        self.eventHandler?(.dataLoaded)
                    } else{
                        self.eventHandler?(.error("Unable to save"))
                    }
                    
                case .failure(let failure):
                    self.eventHandler?(.error(failure.errorDescription))
                }
            }
        }
        
        
        
    }
    
}
