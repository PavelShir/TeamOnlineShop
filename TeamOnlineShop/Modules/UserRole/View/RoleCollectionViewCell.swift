//
//  RoleCollectionViewCell.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 29.04.2024.
//

import UIKit

final class RoleCollectionViewCell: UICollectionViewCell {
    static let identifier = RoleCollectionViewCell.debugDescription()

    private let roleNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.font = UIFont.TextFont.Screens.ProfileScreen.menuItem
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = UIColor(named: Colors.blackPrimary)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            checkmarkImageView.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(roleNameLabel)
        contentView.addSubview(checkmarkImageView)
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor(named: Colors.greyLight)?.cgColor
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor(named: Colors.greyLighter)
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roleNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            roleNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            roleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            roleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with role: String) {
        roleNameLabel.text = role
    }
}
