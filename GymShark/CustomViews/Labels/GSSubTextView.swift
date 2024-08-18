//
//  GSSubTextView.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class GSSubTextView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment =  textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor = .label
        numberOfLines = 3
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
