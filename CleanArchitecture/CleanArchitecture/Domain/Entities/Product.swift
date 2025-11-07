//
//  Product.swift
//  CleanArchitecture
//
//  Enterprise Business Rules - Entity
//

import Foundation

/// Entidade de domínio representando um Produto
/// Não depende de frameworks externos
struct Product: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var price: Double
    var categoryId: UUID
    
    init(id: UUID = UUID(), name: String, price: Double, categoryId: UUID) {
        self.id = id
        self.name = name
        self.price = price
        self.categoryId = categoryId
    }
}


