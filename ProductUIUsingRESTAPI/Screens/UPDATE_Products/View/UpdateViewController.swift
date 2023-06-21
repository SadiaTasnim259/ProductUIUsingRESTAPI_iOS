//
//  UpdateViewController.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 21/6/23.
//

import UIKit

class UpdateViewController: UIViewController {

    var updateViewModel = UpdateProductViewModel()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quentityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!

    var updateObject: ProductContent?


    override func viewDidLoad() {
        super.viewDidLoad()

        setupProduct()
        observeEvent()
    }

    func setupProduct() {
        if let updateObject {
            nameTextField.text = updateObject.name ?? ""
            quentityTextField.text = "\(updateObject.quentity ?? 0)"
            priceTextField.text = "\(updateObject.price ?? 0)"
            imageTextField.text = updateObject.image
        }
    }


    func observeEvent() {
        updateViewModel.initEventController { event in
            switch event {
            case .loading:
                break
            case .stopLoading:
                break
            case .dataLoaded:
                self.showAlert(message: "Product Successfully Updated")
            case .error(let string):
                self.openAlert(title: "Alert", message: string ?? "")
            }
        }
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Product Name")
            return
        }
        guard let quentity = quentityTextField.text, !quentity.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Product Quentity")
            return
        }
        guard let price = priceTextField.text, !price.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Product Price")
            return
        }
        guard let image = imageTextField.text, !image.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Product Image URL")
            return
        }

        updateViewModel.Update(id: updateObject?.id ?? "", name: name, price: price, quentity: quentity, image: image)
    }

    // MARK: - Alerts

    func openAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
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
