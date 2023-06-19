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

// MARK: - POST Product

    func addProduct(name: String, quentity: String, price: String, image: String) {

        self.eventHandler?(.loading)

        var params: [String: Any] = [:]
        params["name"] = name
        params["quentity"] = quentity
        params["price"] = price
        params["image"] = image

        NetworkManager.shared.httpRequest(urlString: API.POST_PRODUCT, httpMethodType: .POST(params: params), respnseType: ProductAddResponse.self) { result in
            
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                    if success.flag ?? false{
                        self.eventHandler?(.dataLoaded)
                    }else{
                        self.eventHandler?(.error(NSError(domain: "Unable to save, Error: \(success.message ?? "")", code: 000)))
                    }
                    
                case .failure(let failure):
                    self.eventHandler?(.error(failure))
                }


            }
        }
    }
}
