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
    
    static let font: UIFont = .systemFont(ofSize: 12)
    static let textColor: UIColor = .systemGray3
}

final class AdretisementsListCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(Metrics.verticalSpacing)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metrics.verticalSpacing)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(priceLabel.snp.bottom).offset(Metrics.verticalSpacing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureViews() {
        titleLabel.textColor = Metrics.textColor
        titleLabel.font = Metrics.font
        
        priceLabel.textColor = Metrics.textColor
        priceLabel.font = Metrics.font

        locationLabel.textColor = Metrics.textColor
        locationLabel.font = Metrics.font

        dateLabel.textColor = Metrics.textColor
        dateLabel.font = Metrics.font
    }
}
