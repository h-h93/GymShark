//
//  ProductDescriptionVC.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class ProductDescriptionVC: UIViewController {
    var label = GSBodyLabel(textAlignment: .left)
    var productDescription = String()
    
    init(productDescription: String) {
        super.init(nibName: nil, bundle: nil)
        self.productDescription = productDescription.htmlConvertedString
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLabel()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    
    func configureLabel() {
        label.text = productDescription
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
