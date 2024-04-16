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
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isUserInteractionEnabled = false
            return collectionView
        }()
    
    let slides: [OnboardingModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOnboardingViews()
    }
    
    func setupOnboardingViews() {
        
    }

    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
