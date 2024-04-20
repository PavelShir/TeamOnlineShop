//
//  ManagerView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ManagerViewDelegate: AnyObject {
    func addCategoryTapped()
    func updateCategoryTapped()
    func deleteCategoryTapped()
    
    func addProductTapped()
    func updateProductTapped()
    func deleteProductTapped()
}

final class ManagerView: UIView {
    weak var delegate: ManagerViewDelegate?
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.title
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator = Separator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        setUpViews()
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        [
            title,
            separator,
        ].forEach{ addSubview($0) }
    }
    
    func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
        ])
    }

    
    private func setUpViews(){
        title.text = "Manager Screen"
    }
    
    @objc private func addCategoryTapped(){
        delegate?.addCategoryTapped()
    }
    
    @objc private func updateCategoryTapped(){
        delegate?.updateCategoryTapped()
    }
    
    @objc private func deleteCategoryTapped(){
        delegate?.deleteCategoryTapped()
    }
    
    @objc private func addProductTapped(){
        delegate?.addProductTapped()
    }
    
    @objc private func updateProductTapped(){
        delegate?.updateProductTapped()
    }
    
    @objc private func deleteProductTapped(){
        delegate?.deleteProductTapped()
    }
}
