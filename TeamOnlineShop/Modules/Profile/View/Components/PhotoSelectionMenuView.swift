//
//  PhotoSelectionMenuView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 16.04.2024.
//
import UIKit

protocol PhotoSelectionMenuDelegate: AnyObject {
    func cameraButtonTapped()
    func galleryButtonTapped()
    func deleteButtonTapped()
}

class PhotoSelectionMenuView: UIView {
    
    weak var delegate: PhotoSelectionMenuDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.text = "Change your picture"
        label.textAlignment = .center
        label.font = UIFont.TextFont.Element.AvatarActionsModal.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator = Separator()
    
    private let cameraButton = PhotoSelectionMenuButton(
        label: "Take a photo",
        icon: UIImage.Icons.camera ?? UIImage(),
        backgroundColor: Colors.greyLighter,
        contenColor: Colors.blackPrimary
    )
    
    private let galleryButton = PhotoSelectionMenuButton(
        label: "Choose from gallery",
        icon: UIImage.Icons.galery ?? UIImage(),
        backgroundColor: Colors.greyLighter,
        contenColor: Colors.blackPrimary
    )
    
    private let deleteButton = PhotoSelectionMenuButton(
        label: "Delete photo",
        icon: UIImage.Icons.trash ?? UIImage(),
        backgroundColor: Colors.greyLighter,
        contenColor: Colors.redPrimary
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 340)
        self.layer.cornerRadius = 12
        setupViews()
        setupConstraints()
        setupButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [
            titleLabel,
            separator,
            cameraButton,
            galleryButton,
            deleteButton,
        ].forEach { addSubview($0) }
        backgroundColor = UIColor(named: Colors.greyLightest)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            cameraButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            cameraButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cameraButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cameraButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 20),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            galleryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            galleryButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            deleteButton.heightAnchor.constraint(equalToConstant: 60),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func setupButtonsActions() {
        cameraButton.addTarget(nil, action: #selector(cameraButtonPressed), for: .touchUpInside)
   
        galleryButton.addTarget(nil, action: #selector(galleryButtonPressed), for: .touchUpInside)
    
        deleteButton.addTarget(nil, action: #selector(deleteButtonPressed), for: .touchUpInside)
    }
    
    @objc private func cameraButtonPressed() {
        delegate?.cameraButtonTapped()
    }

    @objc private func galleryButtonPressed() {
        delegate?.galleryButtonTapped()
    }

    @objc private func deleteButtonPressed() {
        delegate?.deleteButtonTapped()
    }
}
