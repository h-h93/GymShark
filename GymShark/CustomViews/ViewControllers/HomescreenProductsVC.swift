//
//  HomescreenProductsVC.swift
//  GymShark
//
//  Created by hanif hussain on 16/08/2024.
//

import UIKit

class HomescreenProductsVC: GSDataLoadingVC, UICollectionViewDelegate {
    enum Section {
        case main
    }
    var collectionView: GSCollectionView!
    var products = [Hit]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Hit>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        configureDataSource()
        configureData()
    }
    
    
    func configure() {
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureCollectionView() {
        let layout = AppLayout.shared.setTwoxTwoCompositionalLayout()
        collectionView = GSCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: self.view)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Hit>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
            cell.backgroundColor = .random
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

}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
}
