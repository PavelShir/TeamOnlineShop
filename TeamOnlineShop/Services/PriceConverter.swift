//
//  PriceConverter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

class PriceConverter {
    static func convert(price: Int, with location: Address) -> Double {
        switch location {
            case .usa: // Цены в долларах остаются без изменений
            return Double(price)
            case .europe: // Конвертация долларов в евро
            return Double(price) * 0.9
            case .russia: // Конвертация долларов в рубли
            return Double(price * 90)
            default:
            return Double(price)
        }
    }
}
