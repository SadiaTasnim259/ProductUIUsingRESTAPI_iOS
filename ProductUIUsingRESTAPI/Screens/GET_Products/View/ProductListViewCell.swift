//
//  ProductListViewCell.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import UIKit

class ProductListViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuentityLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        productBackgroundView.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        self.productBackgroundView.backgroundColor = .systemGray5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ProductDetailConfiguration(product: ProductContent) {
        productNameLabel.text = product.name
        productQuentityLabel.text = "Quentity: \(product.quentity ?? 0) "
        productPriceLabel.text = "$\(product.price ?? 0)"
        productImageView.setImage(with: product.image ?? "")
    }

}
