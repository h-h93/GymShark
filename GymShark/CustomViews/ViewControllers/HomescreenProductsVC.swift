//
//  HomescreenProductsVC.swift
//  GymShark
//
//  Created by hanif hussain on 16/08/2024.
//

import UIKit

protocol HomescreenCollectionViewDelegate: AnyObject {
    func loadProductInfo(product: Hit)
}

class HomescreenProductsVC: GSDataLoadingVC, UICollectionViewDelegate {
    enum Section {
        case main
    }
    var collectionView: GSCollectionView!
    var products = [Hit]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Hit>!
    weak var homescreenCollectionDelegate: HomescreenCollectionViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        configureDataSource()
        configureData()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureCollectionView() {
        collectionView = GSCollectionView(frame: .zero, collectionViewLayout: AppLayout.shared.twoGridLayout(in: view))
        collectionView.register(GSProductCollectionViewCell.self, forCellWithReuseIdentifier: GSProductCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        collectionView.pinToSafeAreaEdges(of: self.view)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Hit>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GSProductCollectionViewCell.reuseID, for: indexPath) as! GSProductCollectionViewCell
            cell.set(product: item)
            return cell
        }
    }

    
    func configureData() {
        showLoadingView()
        defer { dismissLoadingView() }
        Task {
            do {
                let productList: GymsharkProducts = try await NetworkManager.shared.fetchProducts()
                products = productList.hits
                updateProductList()
            } catch {
                presentGSAlert(title: "Oops", message: "We've encountered an error. Please try again.", buttonTitle: "Ok")
            }
        }
    }
    
    
    func updateProductList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Hit>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products, toSection: .main)
        DispatchQueue.main.async{[weak self] in self?.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)}
    }
    
    
    // pagination func
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homescreenCollectionDelegate.loadProductInfo(product: self.products[indexPath.item])
    }

}
