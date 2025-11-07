//
//  ProductUseCases.swift
//  CleanArchitecture
//
//  Application Business Rules - Use Cases
//

import Foundation

/// Casos de uso relacionados a produtos
/// Define O QUE fazer, não COMO fazer
class ProductUseCases {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Busca todos os produtos
    func getAllProducts() async throws -> [Product] {
        return try await repository.fetchProducts()
    }
    
    /// Busca produtos de uma categoria específica
    func getProductsByCategory(_ categoryId: UUID) async throws -> [Product] {
        return try await repository.fetchProducts(by: categoryId)
    }
    
    /// Adiciona um novo produto
    func addProduct(name: String, price: Double, categoryId: UUID) async throws {
        let product = Product(name: name, price: price, categoryId: categoryId)
        try await repository.addProduct(product)
    }
    
    /// Remove um produto
    func removeProduct(_ product: Product) async throws {
        try await repository.deleteProduct(product)
    }
}


