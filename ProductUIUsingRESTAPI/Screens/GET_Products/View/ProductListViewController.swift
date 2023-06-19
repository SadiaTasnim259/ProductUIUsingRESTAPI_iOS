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
        configuration()
    }

    @objc func refresh(_ sender: Any) {
        productViewModel.getProduct()
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
                break
            case .stopLoading:
                self.refreshControl.endRefreshing()
                break
            case .dataLoaded:
                self.indicatorView.stopAnimating()
                self.productList = self.productViewModel.productList
                self.tableView.reloadData()

            case .error(let error):
                print(error)
            }
        }
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
}
