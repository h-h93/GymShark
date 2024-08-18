//
//  ProductInfoImageSlideView.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import UIKit

protocol PageControllerProtocol: AnyObject {
    func updatePageControll(_ pageController: UIPageControl?)
}

class GSProductImageSlidesCollectionView: UICollectionView {
    let pageController = UIPageControl()
    let section = AppLayout.shared.horizontalScrollLayout()
    weak var pageControllerDelegate: PageControllerProtocol!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self,
                  let itemWidth = items.last?.bounds.width else { return }
            let page = round(offset.x / (itemWidth + section.interGroupSpacing))
            pageController.currentPage = Int(page)
        }
        let layout = UICollectionViewCompositionalLayout(section: section)
        setCollectionViewLayout(layout, animated: true)
        
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.backgroundStyle = .prominent
        pageController.currentPageIndicatorTintColor = .systemBlue
        pageController.pageIndicatorTintColor = .systemGray
        pageController.addTarget(self, action: #selector(navigateToItem), for: .touchUpInside)
        
        self.addSubview(pageController)
        NSLayoutConstraint.activate([
            //pageController.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pageController.heightAnchor.constraint(equalToConstant: 10),
            pageController.widthAnchor.constraint(equalToConstant: 320),
            pageController.topAnchor.constraint(equalTo: self.topAnchor, constant: 430),
            pageController.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
    
    
    @objc func navigateToItem(_ sender: UIPageControl) {
        let page = Int(sender.currentPage)
        self.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
    }
}
