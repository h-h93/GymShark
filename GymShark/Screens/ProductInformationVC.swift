//
//  ProductInformationVC.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class ProductInformationVC: UIViewController {
    var product: Hit!
    var productInfoView: ProductInformationView!
    
    init(product: Hit) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure() {
        productInfoView = ProductInformationView(product: product)
        productInfoView.productDetailView.delegate = self
        view.addSubview(productInfoView)
        productInfoView.pinToSafeAreaEdges(of: view)
    }
    
    
    func showProductDescription(description: String) {
        let descriptionVC = ProductDescriptionVC(productDescription: description)
        descriptionVC.modalTransitionStyle = .crossDissolve
        descriptionVC.modalPresentationStyle = .pageSheet
        descriptionVC.sheetPresentationController?.prefersGrabberVisible = true
        present(descriptionVC, animated: true)
    }
}
