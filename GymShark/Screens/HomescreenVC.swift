//
//  ViewController.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

class HomescreenVC: UIViewController {
    private var homescreenProductsVC = HomescreenProductsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        addChild(homescreenProductsVC)
        view.addSubview(homescreenProductsVC.view)
        homescreenProductsVC.view.pinToEdges(of: view)
        homescreenProductsVC.didMove(toParent: self)
    }

}

