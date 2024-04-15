//
//  OnboardingCell.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 16.04.2024.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    private var slideImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var slideFirstLabel: UILabel = {
        let element = UILabel()
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var slideSecondLabel: UILabel = {
        let element = UILabel()
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func setup(_ slide: OnboardingModel) {
            slideImageView.image = slide.image
            slideFirstLabel.text = slide.firstLabel
            slideSecondLabel.text = slide.secondLabel
        }
    
}
