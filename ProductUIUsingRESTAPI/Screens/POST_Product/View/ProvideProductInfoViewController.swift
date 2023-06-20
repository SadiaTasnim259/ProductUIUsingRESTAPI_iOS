//
//  ProvideProductInfoViewController.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import UIKit

class ProvideProductInfoViewController: UIViewController {
    
    var provideProductInfoViewModel = ProvideProductInfoViewModel()
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quentityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observEvent()
    }
    
    func observEvent(){
        provideProductInfoViewModel.initEventController { event in
            switch event {
            case .loading:
                self.indicatorView.startAnimating()
            case .stopLoading:
                self.indicatorView.stopAnimating()
            case .dataLoaded:
                self.showAlert(message: "Product Saved")
            case .error(let string):
                self.openAlert(message: string ?? "Unable to save product")
            }
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            openAlert(message: "Please enter your Product Name")
            return
                }
        guard let quentity = quentityTextField.text, !quentity.isEmpty else {
                    openAlert(message: "Please enter your Product Quentity")
                    return
                }
        guard let price = priceTextField.text, !price.isEmpty else {
                    openAlert(message: "Please enter your Product Price")
                    return
                }
        guard let image = imageTextField.text, !image.isEmpty else {
                    openAlert(message: "Please enter your Image URL")
                    return
                }
        provideProductInfoViewModel.addProduct(name: name, price: price, quentity: quentity, image: image)
    }
    
    
}

// MARK: - Alerts
extension ProvideProductInfoViewController{
    func openAlert(message: String) -> Void {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)

        alert.addAction(okButton)

        self.present(alert, animated: true)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
