//
//  AdvertisementListViewController.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import UIKit
import SnapKit

protocol AdvertisementListViewInput: AnyObject {
    func setDataSource(_ dataSource: AdvertisementListDataSource)
}

final class AdvertisementListViewController: UIViewController {

    private let output: AdvertisementListViewOutput
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    init(output: AdvertisementListViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        output.viewDidLoad()
    }
    
    private func setup() {
        configureViews()
        addConstraints()
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
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

// MARK: - AdvertisementListViewInput

extension AdvertisementListViewController: AdvertisementListViewInput {
    func setDataSource(_ dataSource: AdvertisementListDataSource) {
        collectionView.dataSource = dataSource
    }
}
