//
//  ProductListViewController.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import UIKit

class ProductListViewController: UIViewController {

    var productViewModel = ProductViewModel()
    var refreshControl: UIRefreshControl!
    var productList: [ProductContent] = []

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductListViewCell", bundle: nil), forCellReuseIdentifier: "ProductListViewCell")
    }

    @objc func refresh(_ sender: Any) {
        productViewModel.getProduct()
    }

    override func viewWillAppear(_ animated: Bool) {
        configuration()
    }

    func configuration() {
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        productViewModel.getProduct()
    }

    func observeEvent() {
        productViewModel.initEventController { event in
            switch event {
            case .loading:
                self.indicatorView.startAnimating()
                break
            case .stopLoading:
                self.indicatorView.stopAnimating()
                self.refreshControl.endRefreshing()
            case .dataLoaded:
                self.productList = self.productViewModel.productList
                self.tableView.reloadData()
            case .error(let error):
                self.openAlert(message: error ?? "")
            }
        }
    }

    func openAlert(message: String) -> Void {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

    @IBAction func addButtonAdded(_ sender: UIBarButtonItem) {
        let provideProductInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProvideProductInfoViewController") as! ProvideProductInfoViewController

        self.navigationController?.pushViewController(provideProductInfoViewController, animated: true)
    }


}

// MARK: - TableView

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListViewCell") as? ProductListViewCell else {
            return UITableViewCell()
        }
        let product = productList[indexPath.row]
        cell.ProductDetailConfiguration(product: product)
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Row select effect
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in

            let updateViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController

            let product = self.productList[indexPath.row]
            updateViewController.updateObject = product
            self.navigationController?.pushViewController(updateViewController, animated: true)

        }
        update.backgroundColor = .systemIndigo

        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let product = self.productList[indexPath.row]
            self.productViewModel.deleteProduct(id: product.id ?? "")
        }
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
}
