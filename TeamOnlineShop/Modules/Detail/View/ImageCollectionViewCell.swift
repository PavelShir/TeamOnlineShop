//
//  ImageCollectionViewCell.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 29.04.2024.
//

import UIKit
import AsyncImageView

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = ImageCollectionViewCell.description()

    private var imageView: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: String) {
        imageView.setImage(from: imageUrl)
    }
}
