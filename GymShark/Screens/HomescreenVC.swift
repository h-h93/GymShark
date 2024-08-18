//
//  ViewController.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

class HomescreenVC: UIViewController, HomescreenCollectionViewDelegate {
    private var homescreenProductsVC = HomescreenProductsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        addChild(homescreenProductsVC)
        view.addSubview(homescreenProductsVC.view)
        homescreenProductsVC.view.pinToSafeAreaEdges(of: view)
        homescreenProductsVC.didMove(toParent: self)
        homescreenProductsVC.homescreenCollectionDelegate = self
    }
    
    
    func loadProductInfo(product: Hit) {
        let productInfoView = ProductInformationVC(product: product)
        self.navigationController?.pushViewController(productInfoView, animated: true)
    }

}

