//
//  ProductModel.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftData Model
//

import Foundation
import SwiftData

/// Modelo SwiftData para persistência de produtos
/// Esta é a representação técnica, não a entidade de domínio
@Model
final class ProductModel {
    var id: UUID
    var name: String
    var price: Double
    var categoryId: UUID
    
    init(id: UUID, name: String, price: Double, categoryId: UUID) {
        self.id = id
        self.name = name
        self.price = price
        self.categoryId = categoryId
    }
    
    convenience init(from product: Product) {
        self.init(
            id: product.id,
            name: product.name,
            price: product.price,
            categoryId: product.categoryId
        )
    }
}


