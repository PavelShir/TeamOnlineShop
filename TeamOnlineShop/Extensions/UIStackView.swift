import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(self.addArrangedSubview(_:))
    }
}
