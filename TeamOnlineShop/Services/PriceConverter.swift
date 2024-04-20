//
//  PriceConverter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

class PriceConverter {
    static func convert(price: Int, with location: Location) -> Double {
        switch location {
            case .America: // Цены в долларах остаются без изменений
            return Double(price)
            case .Europe: // Конвертация долларов в евро
            return Double(price) * 0.9
            case .Russia: // Конвертация долларов в рубли
            return Double(price * 90)
            default:
            return Double(price)
        }
    }
}
