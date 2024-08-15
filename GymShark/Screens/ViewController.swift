//
//  ViewController.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

class ViewController: GSDataLoadingVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let product = try await NetworkManager.shared.getProducts()
            } catch {
                presentGSAlert(title: "Oops", message: "We've encountered an error. Please try again.", buttonTitle: "Ok")
            }
        }
    }
}

