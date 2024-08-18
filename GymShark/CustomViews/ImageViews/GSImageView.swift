//
//  GSImageView.swift
//  GymShark
//
//  Created by hanif hussain on 17/08/2024.
//

import UIKit

class GSImageView: UIImageView {
    private var placeHolderImage: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(contentMode: UIView.ContentMode, placeholderImage: UIImage = Images.defaultPlaceHolderImage!) {
        self.init(frame: .zero)
        configure(contentMode: contentMode, placeholderImage: placeholderImage)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(contentMode: UIView.ContentMode, placeholderImage: UIImage) {
        translatesAutoresizingMaskIntoConstraints = false
        self.placeHolderImage = placeholderImage
        self.contentMode = contentMode
        self.clipsToBounds = true
        image = placeHolderImage
    }
    
    
    func set(urlString: String) {
        Task(priority: .low) {
            image = try await NetworkManager.shared.fetchImage(urlString: urlString) ?? placeHolderImage
        }
    }
}
