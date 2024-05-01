//
//  ProfileViewController.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let presenter: ProfilePresenterProtocol
    private let customView = ProfileView()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let photoSelectionMenuView =  PhotoSelectionMenuView()
    private let imagePicker = UIImagePickerController()
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        setupPhotoSelectionMenu()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        (tabBarController as? TabBarController)?.updateManagerTabBarItemState()
//        if let tabBar = tabBarController as? TabBarController {
//            tabBar.updateManagerTabBarItemState()
//        }
    }
    
   
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func roleButtonTapped() {
        self.presenter.goToUserRoleVC()
    }
    
    func signOutButtonTapped() {
        AuthManager.shared.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let vc = OnboardingViewController()
//            vc.modalPresentationStyle = .fullScreen
            self.view.window?.rootViewController = vc
        }
    }
    
    func termsAndConditionsButtonTapped() {
        self.presenter.goToTermsAndConditionsVC()
    }
    
    func changeProfileImage() {
        showPhotoSelectionMenu()
    }
    
    func showPhotoSelectionMenu() {
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.addSubview(photoSelectionMenuView)
    }
    
    func hidePhotoSelectionMenu() {
        blurEffectView.removeFromSuperview()
        photoSelectionMenuView.removeFromSuperview()
    }
}

extension ProfileViewController: ProfilePresenterViewProtocol {
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Не удалось получить выбранное изображение")
            picker.dismiss(animated: true, completion: nil)
            return
        }
        UserManager.shared.updateUserAvatar(avatar: selectedImage) { error in
            if error != nil {
                print("Error is occured during saving new user avatar")
            }
        }
        customView.updateProfileImage(selectedImage)
        hidePhotoSelectionMenu()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController: PhotoSelectionMenuDelegate {
    func cameraButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Камера недоступна")
            return
        }
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func galleryButtonTapped() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func deleteButtonTapped() {
        customView.updateProfileImage()
        hidePhotoSelectionMenu()
    }
}

private extension ProfileViewController {
    
    //MARK: - Private methods
    func setupCustomView() {
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        customView.delegate = self
        customView.configView(with: UserManager.shared.getUserProfileData())
    }
    
    func setupPhotoSelectionMenu() {
        photoSelectionMenuView.delegate = self
        photoSelectionMenuView.center = view.center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideMenu))
                view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOutsideMenu() {
        hidePhotoSelectionMenu()
    }
}
