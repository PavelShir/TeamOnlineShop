//
//  OnboardingModel.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 16.04.2024.
//

import UIKit

struct OnboardingModel {
    
    let image: UIImage
    let firstLabel: String
    let secondLabel: String
    
    static let slides = [
        OnboardingModel(image: #imageLiteral(resourceName: "imageOne"), firstLabel: "20% Discount\nNew Arrival Product", secondLabel: "Publish up your selfies to make yourself more beautifull with this app."),
        OnboardingModel(image: #imageLiteral(resourceName: "imageTwo"), firstLabel: "Take Advantage\nOf The Offer Shopping", secondLabel: "Publish up your selfies to make yourself more beautifull with this app."),
        OnboardingModel(image: #imageLiteral(resourceName: "imageThree"), firstLabel: "All Types Offers\nWithing Your Reach", secondLabel: "Publish up your selfies to make yourself more beautifull with this app.")
    ]
    
}
