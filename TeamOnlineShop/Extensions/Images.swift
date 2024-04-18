//
//  Images.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 15.04.2024.
//


import UIKit.UIImage

extension UIImage {
    enum Icons {
        static var home: UIImage? {
            return UIImage(systemName: "house")
        }
        
        static var wishlist: UIImage? {
            return UIImage(systemName: "heart")
        }
        
        static var manager: UIImage? {
            return UIImage(systemName: "doc.text")
        }
        
        static var user: UIImage? {
            return UIImage(systemName: "person")
        }
        
        static var cart: UIImage? {
            return UIImage(systemName: "cart")
        }
        
        static var search: UIImage? {
            return UIImage(systemName: "magnifyingglass")
        }
        
        static var arrowLeft: UIImage? {
            return UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }

        static var chevronRight: UIImage? {
            return UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }
        
        static var chevronDown: UIImage? {
            return UIImage(systemName: "chevron.down")
        }
        
        static var secureInputShown: UIImage? {
            return UIImage(systemName: "eye.slash")
        }
        
        static var secureInputHiden: UIImage? {
            return UIImage(systemName: "eye")
        }
        
        static var signout: UIImage? {
            return UIImage(systemName: "rectangle.portrait.and.arrow.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        }
        
        static var userAvatar: UIImage? {
            return UIImage(systemName: "person.crop.circle.fill")
        }
        
        static var trash: UIImage? {
            return UIImage(systemName: "trash")
        }
        
        static var remove: UIImage? {
            return UIImage(systemName: "xmark")
        }
        
        static var minus: UIImage? {
            return UIImage(systemName: "minus.circle")
        }
        
        static var plus: UIImage? {
            return UIImage(systemName: "plus.circle")
        }
        
        static var edit: UIImage? {
            return UIImage(systemName: "pencil.circle")
        }
        
        static var history: UIImage? {
            return UIImage(systemName: "clock")
        }
        
        static var filter: UIImage? {
            return UIImage(systemName: "line.3.horizontal.decrease.circle")
        }
        
        static var filterFill: UIImage? {
            return UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        }
        
        static var allCategories: UIImage? {
            return UIImage(systemName: "square.grid.2x2")
        }
        
        static var bell: UIImage? {
            return UIImage(systemName: "bell")
        }
        
        static var nextSlide: UIImage? {
            return UIImage(systemName: "arrow.forward.circle")
        }
        
        static var camera: UIImage? {
            return UIImage(systemName: "camera")
        }
        
        static var galery: UIImage? {
            return UIImage(systemName: "photo.on.rectangle.angled")
        }
        
        static var folder: UIImage? {
            return UIImage(systemName: "folder")
        }
        
    }
    
    enum Images {
        static var noImage: UIImage? {
            return UIImage(named: "no-image")
        }
    }
}
