//
//  OnboardingViewController.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 16.04.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    private lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .system)
        nextBtn.backgroundColor = .black
        nextBtn.setImage(UIImage.Icons.nextSlide, for: .normal)
        nextBtn.tintColor = .white
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.imageView?.contentMode = .center
        nextBtn.layer.cornerRadius = 30
        
        return nextBtn
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    //private let slides = OnboardingModel.slides
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupOnboardingViews()
        setupViewLayaut()
    }
    
    func setupOnboardingViews() {
        view.addSubview(collectionView)
        view.addSubview(nextBtn)
        view.addSubview(pageControl)
    }
    
    func setupViewLayaut() {
        NSLayoutConstraint.activate([
            // Констрейнты для collectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            // Констрейнты для pageControl
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            // Констрейнты для nextBtn
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            nextBtn.widthAnchor.constraint(equalToConstant: 60),
            nextBtn.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func nextBtnTapped() {
        if currentPage == OnboardingModel.slides.count - 1 {
            UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.modalTransitionStyle = .flipHorizontal
            present(navigationController, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }
        print("Next button tapped!")
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.setup(OnboardingModel.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
