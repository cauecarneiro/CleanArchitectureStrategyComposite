//
//  SortStrategy.swift
//  CleanArchitecture
//
//  Interface Adapters - Strategy Pattern
//

import Foundation

/// Protocolo Strategy para diferentes formas de ordenação
protocol SortStrategy {
    func sort(_ products: [Product]) -> [Product]
}

/// Estratégia: Ordenar por nome (A-Z)
struct SortByNameStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.name < $1.name }
    }
}

/// Estratégia: Ordenar por preço (menor para maior)
struct SortByPriceStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.price < $1.price }
    }
}

/// Estratégia: Ordenar por preço (maior para menor)
struct SortByPriceDescendingStrategy: SortStrategy {
    func sort(_ products: [Product]) -> [Product] {
        return products.sorted { $0.price > $1.price }
    }
}


