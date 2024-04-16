//
//  Fonts.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 15.04.2024.
//

import UIKit.UIFont

extension UIFont {
    enum SystemFonts {
        enum PlusJakartaSans {
            static let bold = "PlusJakartaSans-Bold"
            static let medium = "PlusJakartaSans-Medium"
            static let semibold = "PlusJakartaSans-SemiBold"
        }
        
        enum Inter {
            static let bold = "Inter-Bold"
            static let medium = "Inter-Medium"
            static let regular = "Inter-Regular"
            static let semibold = "Inter-SemiBold"
        }
    }
    
    enum PlusJakartaSansFont {
        enum Bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.PlusJakartaSans.bold, size: size) ?? UIFont()
            }
        }
        enum Medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.PlusJakartaSans.medium, size: size) ?? UIFont()
            }
        }
        enum SemiBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.PlusJakartaSans.semibold, size: size) ?? UIFont()
            }
        }
    }
    
    enum InterFont {
        enum Regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.regular, size: size) ?? UIFont()
            }
        }
        
        enum Medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.medium, size: size) ?? UIFont()
            }
        }
        
        enum Bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.bold, size: size) ?? UIFont()
            }
        }
        
        enum SemiBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: SystemFonts.Inter.semibold, size: size) ?? UIFont()
            }
        }
    }
    
    enum TextFont {
        enum Element {
            
            enum Button {
                static let small = InterFont.Regular.size(of: 12)
                static let normal = InterFont.Medium.size(of: 14)
                static let large = InterFont.Regular.size(of: 16)
            }
            
            enum Input {
                static let label = PlusJakartaSansFont.Medium.size(of: 14)
                static let inputText = PlusJakartaSansFont.Medium.size(of: 16)
            }
            
            enum TabBar {
                static let label = InterFont.Regular.size(of: 10)
            }
            
            enum ProductCard {
                static let title = InterFont.Regular.size(of: 12)
                static let price = InterFont.SemiBold.size(of: 14)
            }
            
            enum SearchBar {
                static let text = InterFont.Regular.size(of: 13)
            }
            
            enum Location {
                static let label = InterFont.Regular.size(of: 10)
                static let address = InterFont.Medium.size(of: 12)
            }
        }
        
        enum Screens {
            
            static let title = InterFont.Medium.size(of: 16)
            static let text = InterFont.Regular.size(of: 14)
            
            enum SearchScreen {
                static let lastSearchText = InterFont.Medium.size(of: 16)
                static let clearAllText = InterFont.Medium.size(of: 12)
                static let historyItemText = InterFont.Regular.size(of: 14)
                static let searchResultsText = InterFont.Regular.size(of: 14)
            }
            
            enum ShopCart {
                static let orderSummaryLabel = InterFont.SemiBold.size(of: 14)
                static let totalsLabel = InterFont.Regular.size(of: 14)
                static let amount = InterFont.SemiBold.size(of: 14)
            }
            
            enum ShopCartItem {
                static let title = InterFont.SemiBold.size(of: 14)
                static let variant = InterFont.Regular.size(of: 12)
                static let price = InterFont.SemiBold.size(of: 14)
            }
            
            
            enum MainScreen {
                static let categoryTitle = InterFont.Regular.size(of: 12)
                static let productsLabel = InterFont.Medium.size(of: 14)
                
            }
            
            enum ProfileScreen {
                static let menuItem = InterFont.SemiBold.size(of: 16)
                static let name = InterFont.SemiBold.size(of: 16)
                static let email = InterFont.Regular.size(of: 14)
                static let password = InterFont.Regular.size(of: 14)
            }
            
            enum ManagerScreen {
                static let propertyLabel = InterFont.Bold.size(of: 13)
                static let propertyValue = InterFont.Medium.size(of: 13)
            }
            
            enum OnboardingScreen {
                static let title = InterFont.SemiBold.size(of: 32)
                static let text = InterFont.Medium.size(of: 16)
            }
            
            enum LoginScreen {
                static let title = PlusJakartaSansFont.Bold.size(of: 18)
                static let completeText = PlusJakartaSansFont.Bold.size(of: 24)
                static let switchText = PlusJakartaSansFont.SemiBold.size(of: 16)
            }
            
            enum PaymentSuccess {
                static let title = InterFont.SemiBold.size(of: 16)
                static let text = InterFont.Regular.size(of: 12)
            }
            
            enum ProductDetail {
                static let title = InterFont.Medium.size(of: 16)
                static let price = InterFont.Medium.size(of: 18)
                static let descriptionLabel = InterFont.Medium.size(of: 16)
                static let descriptionText = InterFont.Regular.size(of: 12)
            }
        }
    }
}
