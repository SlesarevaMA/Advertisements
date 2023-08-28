//
//  AdvertisementListViewController.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import UIKit
import SnapKit

final class AdvertisementListViewController: UIViewController {
    
    private let collectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setDataSource(_ dataSource: DataSource) {
        collectionView.dataSource = dataSource
    }
    
    private func setup() {
        configureViews()
        addConstraints()
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        
        collectionView.register(cell: AdretisementsListCell.self)
    }
    
    private func configureViews() {
        view.addSubview(collectionView)
    
        collectionView.backgroundColor = .black
    }
    
    private func addConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.snp.margins)
        }
    }
}

extension AdvertisementListViewController: UICollectionViewDelegate {
    
}
