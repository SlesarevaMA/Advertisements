//
//  AdvertisementViewController.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

private enum Metrics {
    static let horizontalSpacing: CGFloat = 12
    static let verticalSpacing: CGFloat = 8
    
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        static let price: UIFont = .boldSystemFont(ofSize: 19)
        static let additional: UIFont = .systemFont(ofSize: 15)
    }
}

protocol AdvertisementViewInput: AnyObject {
    func setModel(_ model: AdvertisementDetailModel)
}

final class AdvertisementViewController: UIViewController {
    
    private let output: AdvertisementViewOutput
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let adressLabel = UILabel()
    
    init(output: AdvertisementViewOutput) {
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
        addSubviews()
        addConstraints()
        configureViews()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            titleLabel,
            priceLabel,
            locationLabel,
            imageView,
            dateLabel,
            descriptionLabel,
            emailLabel,
            phoneNumberLabel,
            adressLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    private func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(view.bounds.width)
            $0.height.equalTo(imageView.snp.width)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Metrics.horizontalSpacing)
            $0.top.equalTo(imageView.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(priceLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(dateLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(locationLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(emailLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        adressLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.leading)
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(Metrics.verticalSpacing)
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_imageIndicator?.startAnimatingIndicator()
        
        let additionalFont = Metrics.Font.additional
        
        priceLabel.font = Metrics.Font.price
        titleLabel.font = Metrics.Font.title
        
        descriptionLabel.font = additionalFont
        descriptionLabel.numberOfLines = 2

        dateLabel.textColor = .secondaryLabel
        dateLabel.font = Metrics.Font.title
        
        locationLabel.textColor = .secondaryLabel
        locationLabel.font = additionalFont
        
        emailLabel.textColor = .secondaryLabel
        emailLabel.font = additionalFont

        phoneNumberLabel.font = additionalFont

        adressLabel.textColor = .secondaryLabel
        adressLabel.font = additionalFont
    }
    
    private func configure(with model: AdvertisementDetailModel) {
        titleLabel.text = model.title
        priceLabel.text = model.price
        locationLabel.text = model.location
        imageView.sd_setImage(with: model.imageUrl)
        dateLabel.text = model.createdDate
        descriptionLabel.text = model.description
        emailLabel.text = model.email
        phoneNumberLabel.text = model.phoneNumber
        adressLabel.text = model.address
    }
}

// MARK: - AdvertisementViewInput

extension AdvertisementViewController: AdvertisementViewInput {
    func setModel(_ model: AdvertisementDetailModel) {
        configure(with: model)
    }
}
