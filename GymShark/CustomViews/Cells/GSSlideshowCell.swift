//
//  GSSlideshowCell.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class GSSlideshowCell: UICollectionViewCell {
    private let imageView = GSImageView(contentMode: .scaleToFill)
    static let reuseID = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
    func set(urlString: String?) {
        if let articlePicture = urlString {
            imageView.set(urlString: "\(articlePicture)")
        }
    }
}
