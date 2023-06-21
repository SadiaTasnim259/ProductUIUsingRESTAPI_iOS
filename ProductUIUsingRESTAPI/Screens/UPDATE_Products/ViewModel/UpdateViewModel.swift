//
//  UpdateViewModel.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 21/6/23.
//

import Foundation

final class UpdateProductViewModel{
    
    var eventHandler: ((_ event: Event) -> Void)?

// MARK: - Event handler initialization
    func initEventController(_ event: @escaping (_ event: Event) -> Void) {
        self.eventHandler = event
    }
    
// MARK: - Update Product
    
    func Update(id:String, name:String, price:String, quentity:String, image:String){
        
        var parameter:[String:Any] = [:]
        parameter["name"] = name
        parameter["price"] = price
        parameter["quentity"] = quentity
        parameter["image"] = image
        
        self.eventHandler?(.loading)
        
        
        NetworkManager.shared.httpRequest(urlString: API.UPDATE_PRODUCT+id, httpMethodType: .PUT(params: parameter), respnseType: ProductUpdateResponse.self) { result in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                    if success.flag ?? false{
                        self.eventHandler?(.dataLoaded)
                    }else{
                        self.eventHandler?(.error("Unable to Update"))
                    }
                    
                case .failure(let failure):
                    self.eventHandler?(.error(failure.errorDescription))
                }
            }
        }
    }
}
