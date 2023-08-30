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
    func showAlert(title: String, completion: @escaping () -> Void)
}

final class AdvertisementViewController: UIViewController {
    
    private let output: AdvertisementViewOutput
    
    private var advertisementId = ""
    
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
        [titleLabel, priceLabel, locationLabel, imageView, dateLabel,
         descriptionLabel, emailLabel, phoneNumberLabel, adressLabel]
            .forEach { view.addSubview($0) }
    }
    
    private func addConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
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
            $0.bottom.equalToSuperview().offset(Metrics.verticalSpacing)
        }
    }
    
    private func configureViews() {
        priceLabel.textColor = Metrics.Color.mainText
        priceLabel.font = Metrics.Font.title
        
        titleLabel.textColor = Metrics.Color.mainText
        titleLabel.font = Metrics.Font.title
        
        descriptionLabel.textColor = Metrics.Color.mainText
        descriptionLabel.font = Metrics.Font.title

        dateLabel.textColor = Metrics.Color.mainText
        dateLabel.font = Metrics.Font.title
        
        locationLabel.textColor = Metrics.Color.mainText
        locationLabel.font = Metrics.Font.title
        
        emailLabel.textColor = Metrics.Color.mainText
        emailLabel.font = Metrics.Font.title

        phoneNumberLabel.textColor = Metrics.Color.mainText
        phoneNumberLabel.font = Metrics.Font.title

        adressLabel.textColor = Metrics.Color.mainText
        adressLabel.font = Metrics.Font.title
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
    
    func showAlert(title: String, completion: @escaping () -> Void) {
        
    }
}
