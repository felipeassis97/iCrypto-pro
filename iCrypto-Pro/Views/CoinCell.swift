//
//  CoinCell.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import UIKit
import SDWebImage

class CoinCell: UITableViewCell {
    static let identifier: String = "CoinCell"
    private(set) var coin: Coin!
    
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "questionmark")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        return iv
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Default"
        return label
    }()
    
    private func setupUI() {
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16)
        ])
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        self.coinName.text = coin.name
        self.coinLogo.sd_setImage(with: coin.logoURL)
        
//        DispatchQueue.global().async { [weak self] in
//            if let logoURL = coin.logoURL,
//               let imageData = try? Data(contentsOf: logoURL),
//               let logoImage = UIImage(data: imageData) {
//                DispatchQueue.main.async { [weak self] in
//                    self?.coinLogo.image = logoImage
//                }
//            }
//        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
