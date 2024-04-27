//
//  SearchBarView.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import UIKit

class CustomSearchBarView: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearenceTextField()
        setupAppearenceSeacrhBar()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let color = UIColor(named: Colors.greyPrimary)
    private let backColor = UIColor.clear
  
    private func setupAppearenceTextField(){
        let textField = self.searchTextField
        textField.textColor = color
        textField.backgroundColor = backColor
        textField.font = UIFont.TextFont.Element.SearchBar.text
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor(named: Colors.greyPrimary)?.cgColor
        textField.layer.borderWidth = 0.5
        
        // Create a custom view for leftView
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) // 40 width + spacing between leftView and search
        if let image = UIImage.Icons.search {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            imageView.tintColor = color
            leftView.addSubview(imageView)
        }
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        // Change color of placeholder text
        let attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: color ?? .black])
        textField.attributedPlaceholder = attributedPlaceholder
    }
    
    private func setupAppearenceSeacrhBar(){
        let backgroundImage =  UIImage.imageWithColor(color: backColor)
        setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}

