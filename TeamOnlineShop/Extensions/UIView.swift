import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(self.addSubview(_:))
    }
    
    func disableAutoResizingInSubviews() {
           self.subviews.forEach { subview in
               subview.translatesAutoresizingMaskIntoConstraints = false
           }
       }
}
