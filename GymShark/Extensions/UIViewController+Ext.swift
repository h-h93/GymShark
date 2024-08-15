//
//  UIViewController+Ext.swift
//  GymShark
//
//  Created by hanif hussain on 15/08/2024.
//

import UIKit

extension UIViewController {
    func presentGSAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GSAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
