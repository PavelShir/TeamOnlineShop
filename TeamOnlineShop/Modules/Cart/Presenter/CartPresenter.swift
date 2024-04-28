//
//  CartPresenter.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit

struct CartViewModel {
    let items: [CartItemCell]
    let totalPrice: String
}

protocol CartViewController: AnyObject {
    func render(_ viewModel: CartViewModel)
}

protocol CartPresenterProtocol: AnyObject {
    init(router: CartRouterProtocol, data: Cart)
    
    func viewDidLoad()
    func dismissCartVC()
    func didSelectCartItem(at index: Int)
    func didDeselectCartItem(at index: Int)
    func didTapPayButton()
    func isSelectedItem(at index: Int) -> Bool
}

final class CartPresenter: CartPresenterProtocol {
    private let router: CartRouterProtocol
    private var cartItems: [CartItem]
    
    weak var view: CartViewController?
    
    //MARK: - init(_:)
    required init(router: CartRouterProtocol, data: Cart) {
        self.router = router
        self.cartItems = data.items
    }
    
    //MARK: - Public methods
    func dismissCartVC() {
        router.dismissCartVC()
    }
    
    func didSelectCartItem(at index: Int) {
        guard cartItems.indices.contains(index) else { return }
        cartItems[index].selected = true
        updateUI()
    }
    
    func didDeselectCartItem(at index: Int) {
        guard cartItems.indices.contains(index) else { return }
        cartItems[index].selected = false
        updateUI()
    }
    
    func didTapPayButton() {
        router.goToPaymentsVC(onContinue: { [weak self] in
            self?.cartItems.removeAll(where: \.selected)
            self?.updateUI()
        })
    }
    
    func viewDidLoad() {
        updateUI()
    }
    
    func isSelectedItem(at index: Int) -> Bool {
        cartItems[safe: index]?.selected ?? false
    }
    
}

private extension CartPresenter {
    func updateUI() {
        let items = cartItems.reduce(
            into: [CartItemCell]()
        ) { [self] partialResult, cartItem in
            let cartItemCell = CartItemCell(
                item: cartItem,
                increaseCounter: { self.increaseCounter(for: cartItem.id) },
                decreaseCounter: { self.decreaseCounter(for: cartItem.id) },
                deleteItem: { self.deleteItem(withId: cartItem.id) }
            )
            partialResult.append(cartItemCell)
        }
        view?.render(
            .init(
                items: items,
                totalPrice: "$ ".appending(computePrice(cartItems))
            )
        )
    }
    
    func computePrice(_ items: [CartItem]) -> String {
        items
            .filter(\.selected)
            .map { $0.price * Float($0.count) }
            .reduce(0.0, +)
            .description
    }
    
    func increaseCounter(for id: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == id }) else { return }
        cartItems[index].count += 1
        updateUI()
    }
    
    func decreaseCounter(for id: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == id }) else { return }
        if cartItems[index].count > .zero {
            cartItems[index].count -= 1
            updateUI()
        }
    }
    
    func deleteItem(withId id: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == id }) else { return }
        cartItems.remove(at: index)
        updateUI()
    }
}
