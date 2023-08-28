//
//  AdretisementsListCell.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import UIKit
import SDWebImage
import SnapKit

private enum Metrics {
    static let verticalSpacing: CGFloat = 8
    
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        static let price: UIFont = .boldSystemFont(ofSize: 19)
        static let additional: UIFont = .systemFont(ofSize: 15)
    }
    
    enum Color {
        static let additional: UIColor = .systemGray
        static let mainText: UIColor = .white
    }
}

final class AdretisementsListCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: AdvertesementListViewModel) {
        imageView.sd_setImage(with: model.imageUrl)
        titleLabel.text = model.title
        priceLabel.text = model.price
        locationLabel.text = model.location
        dateLabel.text = model.date
    }
    
    private func setup() {
        addSubview()
        addConstraint()
        configureViews()
    }
    
    private func addSubview() {
        [imageView, titleLabel, priceLabel, locationLabel, dateLabel].forEach { addSubview($0) }
    }
    
    private func addConstraint() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(priceLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    private func configureViews() {
        titleLabel.textColor = Metrics.Color.mainText
        titleLabel.font = Metrics.Font.title
        titleLabel.numberOfLines = 2
        
        priceLabel.textColor = Metrics.Color.mainText
        priceLabel.font = Metrics.Font.price

        locationLabel.textColor = Metrics.Color.additional
        locationLabel.font = Metrics.Font.additional

        dateLabel.textColor = Metrics.Color.additional
        dateLabel.font = Metrics.Font.additional
    }
}
