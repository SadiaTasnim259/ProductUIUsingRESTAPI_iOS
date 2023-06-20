//
//  ProductViewModel.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation


final class ProductViewModel{
    
    var productList:[ProductContent] = []
    
    var eventHandler:((_ event:Event) -> Void)?
    
    // MARK: - Event handler initialization
    func initEventController( _ event:@escaping (_ event:Event) -> Void)   {
        self.eventHandler = event
    }

    // MARK: - GET product

    func getProduct(){
        self.eventHandler?(.loading)
        
        NetworkManager.shared.httpRequest(urlString: API.GET_ALL_PRODUCTS, httpMethodType: .GET, respnseType: GetProductModelList.self) { result in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                    self.productList = success.content ?? []
                    self.eventHandler?(.dataLoaded)
                case .failure(let failure):
                    self.eventHandler?(.error(failure.localizedDescription))
                }
            }
        }
    }
}

// MARK: - Delete product

extension ProductViewModel{
    
    func deleteProduct(id:String){
        self.eventHandler?(.loading)
        
        NetworkManager.shared.httpRequest(urlString: API.DELETE_PRODUCT+id, httpMethodType: .DELETE, respnseType: ProductAddResponse.self) { result in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                    if success.flag ?? false{
                        self.getProduct()
                    }else{
                        self.eventHandler?(.error("Unable to delete"))
                    }
                    
                case .failure(let failure):
                    self.eventHandler?(.error(failure.errorDescription))
                }
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4){ // akn theke 4 sec por ei function er vitorer code execute korbe
//            self.eventHandler?(.stopLoading)
//        }
    }
}

