//
//  ProductDetailView.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class ProductDetailView: UIView, UITableViewDataSource, UITableViewDelegate {
    var product: Hit!
    var titleLabel = GSTitleLabel(textAlignment: .center, fontSize: 20)
    var fitLabel = GSBodyLabel(textAlignment: .center)
    var priceLabel = GSTitleLabel(textAlignment: .center, fontSize: 14)
    var sizeContainerView = UIView()
    var sizes = [
        "XXS", "XS", "S", "M", "L", "XL", "XXL"
    ]
    var sizeHeading = GSSubTextView(textAlignment: .left, fontSize: 14)
    var sizeLabels = [GSSubTextView]()
    var tableView = UITableView()
    var buyButton = GSButton(colour: .systemBlue, title: "BUY NOW", systemImageName: "")
    var tableViewHeadings = ["DESCRIPTION"]
    weak var delegate: ProductInformationVC!
    
    init(product: Hit) {
        super.init(frame: .zero)
        self.product = product
        configure()
        configureLabels()
        configureSizeView()
        configureTableView()
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureLabels() {
        titleLabel.text = product.title
        fitLabel.text = product.fit
        priceLabel.text = "£" + "\(product.price)"
        addSubviews(titleLabel, fitLabel, priceLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            
            fitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            fitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            fitLabel.widthAnchor.constraint(equalToConstant: 50),
            fitLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: fitLabel.bottomAnchor, constant: 5),
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            priceLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 16),
        ])
    }
    
    
    func configureSizeView() {
        sizeContainerView.backgroundColor = .systemBackground
        sizeContainerView.translatesAutoresizingMaskIntoConstraints = false
        sizeContainerView.layer.borderColor = UIColor.systemGray.cgColor
        sizeContainerView.layer.cornerRadius = 5
        sizeContainerView.layer.borderWidth = 0.5
        
        sizeHeading.text = "Select Size"
        
        addSubviews(sizeContainerView, sizeHeading)
        
        for size in sizes {
            let label = GSSubTextView(textAlignment: .center, fontSize: 12)
            if checkSizeInStock(size: size) {
                let attributedText = NSAttributedString(
                    string: "\(size)",
                    attributes: [.strikethroughStyle: NSUnderlineStyle.thick.rawValue]
                )
                label.attributedText = attributedText
            } else {
                label.text = size
            }
            sizeLabels.append(label)
            sizeContainerView.addSubview(label)
        }
        
        NSLayoutConstraint.activate([
            sizeContainerView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 60),
            sizeContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            sizeContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            sizeContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            sizeHeading.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            sizeHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            sizeHeading.widthAnchor.constraint(equalToConstant: 55),
            sizeHeading.heightAnchor.constraint(equalToConstant: 25),
            
            sizeLabels.first!.centerYAnchor.constraint(equalTo: sizeContainerView.centerYAnchor),
            sizeLabels.first!.leadingAnchor.constraint(equalTo: sizeContainerView.leadingAnchor, constant: 10),
            sizeLabels.first!.widthAnchor.constraint(equalToConstant: 25),
            sizeLabels.first!.heightAnchor.constraint(equalToConstant: 20),
        ])

        for index in 1...6 {
            NSLayoutConstraint.activate([
                sizeLabels[index].centerYAnchor.constraint(equalTo: sizeContainerView.centerYAnchor),
                sizeLabels[index].leadingAnchor.constraint(equalTo: sizeLabels[index-1].trailingAnchor, constant: 25),
                sizeLabels[index].widthAnchor.constraint(equalToConstant: 25),
                sizeLabels[index].heightAnchor.constraint(equalToConstant: 20),
            ])
        }
    }
    
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sizeContainerView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            tableView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureButton() {
        addSubview(buyButton)
        buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 100),
            buyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeadings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.text = tableViewHeadings[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.showProductDescription(description: product.description ?? "Description unavailable")
    }
    
    
    @objc func didTapBuyButton() {
        
    }
    
    
    func checkSizeInStock(size: String) -> Bool {
        guard let sizeInStock = product.sizeInStock else { return false }
        for i in sizeInStock {
            if i.rawValue.lowercased() == size.lowercased() {
                return true
            }
        }
        return false
    }
}
