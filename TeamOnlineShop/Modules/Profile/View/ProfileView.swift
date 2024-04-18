//
//  ProfileView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func signOutButtonTapped()
    func termsAndConditionsButtonTapped()
    func changeProfileImage()
}

final class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    
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
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.title
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let profileEmail: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.greyDarker)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.ProfileScreen.email
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profilePassword: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.greyDarker)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.ProfileScreen.password
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let profilePasswordEyeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icons.secureInputHiden
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = UIColor(named: Colors.greyLight)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: Colors.greyLighter)
        imageView.layer.cornerRadius = 50
        imageView.tintColor = UIColor(named: Colors.greenLight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let profileImageEditIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icons.edit
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(named: Colors.bluePrimary)
        imageView.layer.cornerRadius = 15
        imageView.tintColor = UIColor(named: Colors.whitePrimary)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let termsAndConditionsButton = ProfileButtonWithRightIcon(
        label: "Terms & Conditions",
        icon: UIImage.Icons.chevronRight ?? UIImage(),
        backgroundColor: Colors.greyLighter,
        contenColor: Colors.greyDarker
    )
    
    private let signOutButton = ProfileButtonWithRightIcon(
        label: "Sign Out",
        icon: UIImage.Icons.signout ?? UIImage(),
        backgroundColor: Colors.greyLighter,
        contenColor: Colors.greyDarker
    )
    
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
            profileName,
            profileEmail,
            profilePassword,
            profilePasswordEyeIcon,
            profileImage,
            profileImageEditIcon,
            termsAndConditionsButton,
            signOutButton
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

        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 15),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            profileImageEditIcon.widthAnchor.constraint(equalToConstant: 30),
            profileImageEditIcon.heightAnchor.constraint(equalToConstant: 30),
            profileImageEditIcon.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            profileImageEditIcon.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 12),
            profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 24),
            profileName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            profileEmail.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 5),
            profileEmail.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 24),
            profileEmail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            profilePasswordEyeIcon.widthAnchor.constraint(equalToConstant: 16),
            profilePasswordEyeIcon.heightAnchor.constraint(equalToConstant: 16),
            profilePasswordEyeIcon.topAnchor.constraint(equalTo: profileEmail.bottomAnchor, constant: 5),
            profilePasswordEyeIcon.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 24),
            
            profilePassword.topAnchor.constraint(equalTo: profileEmail.bottomAnchor, constant: 5),
            profilePassword.leftAnchor.constraint(equalTo: profilePasswordEyeIcon.rightAnchor, constant: 5),
        ])

        NSLayoutConstraint.activate([
            termsAndConditionsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -20),
            termsAndConditionsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            termsAndConditionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            termsAndConditionsButton.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -28),
            signOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    
    private func setUpViews(){
        title.text = "Profile"
        profileImage.image = UIImage.Icons.userAvatar
        makeProfileImageTappable()
        
        profileName.text = "Dev P"
        profileEmail.text = "dev@test.com"
        
        profilePassword.text = "***********"
        
        termsAndConditionsButton.addTarget(nil, action: #selector(termsAndConditionsButtonTapped), for: .touchUpInside)
        signOutButton.addTarget(nil, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    private func makeProfileImageTappable() {
        if profileImage.gestureRecognizers != nil {
            profileImage.gestureRecognizers?.removeAll()
        }
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(profileImageTapped)
        )
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapRecognizer)
    }
    
    func updateProfileImage(_ image: UIImage? = nil) {
        guard let safeImage = image else {
            profileImage.image = UIImage.Icons.userAvatar
            return
        }
        
        profileImage.image = safeImage
    }
    
    @objc private func signOutButtonTapped(){
        delegate?.signOutButtonTapped()
    }
    
    @objc private func termsAndConditionsButtonTapped(){
        delegate?.termsAndConditionsButtonTapped()
    }
    
    
    @objc private func profileImageTapped(_ gesture: UITapGestureRecognizer) {
        delegate?.changeProfileImage()
    }
}
