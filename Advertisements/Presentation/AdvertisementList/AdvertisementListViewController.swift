//
//  AdvertisementListViewController.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let columnsNumber: CGFloat = 2
    static let spacing: CGFloat = 12
    static let aspectRatio: CGFloat = 1.75
}

protocol AdvertisementListViewInput: AnyObject {
    func setDataSource(_ dataSource: AdvertisementListDataSource)
    func showAlert(title: String, completion: @escaping () -> Void)
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setup() {
        prepareCollectionView()
        configureViews()
        addConstraints()
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
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - AdvertisementListViewInput

extension AdvertisementListViewController: AdvertisementListViewInput {
    func setDataSource(_ dataSource: AdvertisementListDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func showAlert(title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Попробуйте ещё", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AdvertisementListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let colums = Constants.columnsNumber
        let totalHorizontalSpacing = (colums + 1) * Constants.spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / colums
        let itemSize = CGSize(width: itemWidth, height: itemWidth * Constants.aspectRatio)
        
        return itemSize
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constants.spacing, bottom: 0, right: Constants.spacing)
    }
}