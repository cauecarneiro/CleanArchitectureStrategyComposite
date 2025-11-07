//
//  Product.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

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



