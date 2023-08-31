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
    
    enum Color {
        static let additional: UIColor = .systemGray
        static let mainText: UIColor = .white
    }
}

protocol AdvertisementViewInput: AnyObject {
    func setModel(_ model: AdvertisementDetailModel)
}

final class AdvertisementViewController: UIViewController {
    
    private let output: AdvertisementViewOutput
        
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let adressLabel = UILabel()
    
    private let progressView = UIActivityIndicatorView()
    
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
        [titleLabel, priceLabel, locationLabel, imageView, dateLabel,
         descriptionLabel, emailLabel, phoneNumberLabel, adressLabel]
            .forEach { view.addSubview($0) }
    }
    
    private func addConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metrics.verticalSpacing)
        }
    }
    
    private func configureViews() {
        priceLabel.textColor = Metrics.Color.mainText
        priceLabel.font = Metrics.Font.price
        
        titleLabel.textColor = Metrics.Color.mainText
        titleLabel.font = Metrics.Font.title
        
        descriptionLabel.textColor = Metrics.Color.mainText
        descriptionLabel.font = Metrics.Font.additional
        descriptionLabel.numberOfLines = 2

        dateLabel.textColor = Metrics.Color.additional
        dateLabel.font = Metrics.Font.title
        
        locationLabel.textColor = Metrics.Color.additional
        locationLabel.font = Metrics.Font.additional
        
        emailLabel.textColor = Metrics.Color.additional
        emailLabel.font = Metrics.Font.additional

        phoneNumberLabel.textColor = Metrics.Color.mainText
        phoneNumberLabel.font = Metrics.Font.additional

        adressLabel.textColor = Metrics.Color.additional
        adressLabel.font = Metrics.Font.additional
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
