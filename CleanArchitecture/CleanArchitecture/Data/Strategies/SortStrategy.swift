//
//  SortStrategy.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

protocol SortStrategy {
    func sort(_ products: [Product]) -> [Product]
}

struct SortByNameStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.name < $1.name }
    }
}

struct SortByPriceStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.price < $1.price }
    }
}

struct SortByPriceDescendingStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.price > $1.price }
    }
}



