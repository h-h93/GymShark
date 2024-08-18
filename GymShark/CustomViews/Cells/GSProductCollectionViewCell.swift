//
//  GSProductCollectionViewCell.swift
//  GymShark
//
//  Created by hanif hussain on 16/08/2024.
//

import UIKit

class GSProductCollectionViewCell: UICollectionViewCell {
    private let imageView = GSImageView(contentMode: .scaleAspectFill)
    private let titleLabel = GSTitleLabel(textAlignment: .left, fontSize: 16)
    private let colourLabel = GSBodyLabel(textAlignment: .left)
    private let productLabels = GSBodyLabel(textAlignment: .left)
    private let priceLabel = GSTitleLabel(textAlignment: .left, fontSize: 16)
    private let padding: CGFloat = 7
    static let reuseID = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(imageView, titleLabel, productLabels, colourLabel, priceLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40),
            
            productLabels.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            productLabels.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            productLabels.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            productLabels.heightAnchor.constraint(lessThanOrEqualToConstant: 18),
            
            colourLabel.topAnchor.constraint(equalTo: productLabels.bottomAnchor, constant: padding),
            colourLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            colourLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            colourLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: colourLabel.bottomAnchor, constant: padding + 5),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
    func set(product: Hit) {
        imageView.set(urlString: product.featuredMedia.src)
        titleLabel.text = product.title
        colourLabel.text = product.colour
        productLabels.text = ""
        if let text = product.labels {
            for i in text {
                productLabels.text! += i
            }
        }
        priceLabel.text = "£" + "\(product.price)"
    }
}
