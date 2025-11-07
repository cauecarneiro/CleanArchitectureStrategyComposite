//
//  ProductUseCases.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 07/11/25.
//

import Foundation

class ProductUseCases {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllProducts() async throws -> [Product] {
        return try await repository.fetchProducts()
    }
    
    func getProductsByCategory(_ categoryId: UUID) async throws -> [Product] {
        return try await repository.fetchProducts(by: categoryId)
    }
    
    func addProduct(name: String, price: Double, categoryId: UUID) async throws {
        let product = Product(name: name, price: price, categoryId: categoryId)
        try await repository.addProduct(product)
    }
    
    func removeProduct(_ product: Product) async throws {
        try await repository.deleteProduct(product)
    }
}



