//
//  ProductInformationSlideshowView.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

class ProductInformationView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, PageControllerProtocol {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var slideShowCollection: GSProductImageSlidesCollectionView!
    var product: Hit!
    var contentViewHeight: CGFloat = 1000
    var productDetailView: ProductDetailView!
    
    init(product: Hit) {
        super.init(frame: .zero)
        self.product = product
        configure()
        configureSlideShowView()
        configureProductDetailView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.tag = 1
        scrollView.delegate = self
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        contentView.backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToSafeAreaEdges(of: self)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)
        ])
    }
    
    
    func configureSlideShowView() {
        slideShowCollection = GSProductImageSlidesCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        slideShowCollection.register(GSSlideshowCell.self, forCellWithReuseIdentifier: GSSlideshowCell.reuseID)
        slideShowCollection.backgroundColor = .systemBackground
        slideShowCollection.dataSource = self
        slideShowCollection.delegate = self
        slideShowCollection.pageControllerDelegate = self
        updatePageControll(self.slideShowCollection.pageController)
        contentView.addSubview(slideShowCollection)
        
        NSLayoutConstraint.activate([
            slideShowCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            slideShowCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            slideShowCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            slideShowCollection.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    
    func configureProductDetailView() {
        productDetailView = ProductDetailView(product: product)
        contentView.addSubview(productDetailView)
        NSLayoutConstraint.activate([
            productDetailView.topAnchor.constraint(equalTo: slideShowCollection.bottomAnchor),
            productDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productDetailView.heightAnchor.constraint(equalToConstant: 550),
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product.media.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GSSlideshowCell.reuseID, for: indexPath) as! GSSlideshowCell
        cell.set(urlString: product.media[indexPath.item].src)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func updatePageControll(_ pageController: UIPageControl?) {
        pageController?.numberOfPages = product.media.count
    }
}
