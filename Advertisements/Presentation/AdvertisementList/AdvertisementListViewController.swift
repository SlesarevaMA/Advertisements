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
    func reloadData()
    func showAlert(title: String, completion: @escaping () -> Void)
}

final class AdvertisementListViewController: UIViewController {

    private let output: AdvertisementListViewOutput
    private var detail: Detail?
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        prepareCollectionViewLayout()
    }
    
    private func setup() {
        prepareCollectionView()
        addConstraints()
    }
    
    private func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(cell: AdretisementsListCell.self)
        collectionView.backgroundColor = .black
    }
    
    private func prepareCollectionViewLayout() {
        let colums = Constants.columnsNumber
        let totalHorizontalSpacing = (colums + 1) * Constants.spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / colums
        let itemSize = CGSize(width: itemWidth, height: itemWidth * Constants.aspectRatio)
        collectionViewLayout.itemSize = itemSize
        collectionViewLayout.minimumInteritemSpacing = Constants.spacing
        collectionViewLayout.sectionInset = UIEdgeInsets(horizontal: Constants.spacing)
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

extension AdvertisementListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.cellSelected(at: indexPath.item)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
