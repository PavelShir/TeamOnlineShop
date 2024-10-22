//
//  OnboardingCell.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 16.04.2024.
//

import AVFoundation
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    private var slideImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var slideFirstLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.OnboardingScreen.title
        element.numberOfLines = 2
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var slideSecondLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.OnboardingScreen.text
        element.textColor = .gray
        element.numberOfLines = 2
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func setup(_ slide: OnboardingModel) {
        
        slideImageView.image = slide.image
        slideFirstLabel.text = slide.firstLabel
        slideSecondLabel.text = slide.secondLabel
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }
    func setupView() {
        
        addSubview(slideImageView)
        addSubview(slideFirstLabel)
        addSubview(slideSecondLabel)
        
        NSLayoutConstraint.activate([
            
            slideImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            slideImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            slideImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            slideImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            slideFirstLabel.topAnchor.constraint(equalTo: slideImageView.bottomAnchor, constant: 10),
            slideFirstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            slideFirstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //slideFirstLabel.widthAnchor.constraint(equalToConstant: 250),
            
            slideSecondLabel.topAnchor.constraint(equalTo: slideFirstLabel.bottomAnchor, constant: 10),
            slideSecondLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            slideSecondLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //slideSecondLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            //slideSecondLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
}

